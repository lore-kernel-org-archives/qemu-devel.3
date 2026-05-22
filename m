Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9498BCD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 23:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQZgU-00081m-St; Fri, 22 May 2026 19:53:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQZgQ-0007zL-5t
 for qemu-devel@nongnu.org; Fri, 22 May 2026 19:53:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQZgO-0006Pu-Fu
 for qemu-devel@nongnu.org; Fri, 22 May 2026 19:53:37 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MHfQZ53601009
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 23:53:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FowFlprws9kDzQO/oaWX1er/jM0Ry7pFJHzt8HVE7gM=; b=nwni9h6/Ozb964Rd
 8Wsir9ZH6zCTmmcTVxbVCb9hNdl++pQHdbx1hmp3Oj5F5tGr6igAELmKe5SWv+JK
 9MYHZ8MkNoVNazNKHNTfWPANinTsUSMKleKoWv413/V3uA9HQ0zgyAUehWLrAcQU
 Xd7xetnbY7vkKWHNUUGUBajFH3nqafaiYZ887dYjIPqKO9rB/X6ukR5wnrDbaeMV
 ddQNTCsIdaxalf8Qv8zEJ+JYzWAmYnm7zVO1lAJVm97ahnb2qZp9tjxKziCRdoNo
 v77grmjLh9vegkr3ICFW7tmarhEoWN5ymT040Y2iTHCLjwEbTb9eQOeAnpsgWL5C
 vZP17g==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eaury10sg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 23:53:35 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3041ab826ddso5936189eec.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 16:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779494014; x=1780098814; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FowFlprws9kDzQO/oaWX1er/jM0Ry7pFJHzt8HVE7gM=;
 b=boFzOwNNiTz7v4YllSvr8DtOz4RD/C7NBKAVBek8Elt1qFL2cbUgYNF3Q7bg0ChRBj
 qE1rBM+fcbLXOzZJy9+Tiu5u9Cdy7/xin43XXODdmIFGaZEcrrPgF7f8cfKANbdecJ4e
 YU52IeSXVzDrmagTBdkVHUsKdvfWSfcOqvbRWuuIaABaQOUQ7avUeAP9vM2rUaIY3Glr
 Yri5Ktq4vqlgXtwb+pj/d/J6pC7Qgdq1hkyUUZ2H+Vmknb4NkZHCzQQ/RLV41H03EsDg
 QZTKbo5PLZT0Yitr4RCsA60foXXQUxlZy0eC2fsZePIBH2J899NygADdXIEB2QQRLG9x
 mvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779494014; x=1780098814;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FowFlprws9kDzQO/oaWX1er/jM0Ry7pFJHzt8HVE7gM=;
 b=Qy1ZpsNAWH8otH9Dw1SyHcgkZI/z5+a6VQKh4L8rRiKhSK+/avIl9kik7JGaRnJ8zF
 UX9juVOoCmzeks/IGNZ2L5seSeYHJxjbjlg7ohkV7fRUDGA2OhGV4KPq/qrz78FG9agH
 qzoN4Wsd3EFnL5j9EKpIq9dHY/4IaNmKxaoQvbT6T+ZuULj6ThVWrrks4Ukb9ynHLvyO
 /hr4oAPA2+wtFm6nBDeWlnytiZ25+LCPjTxzUvqBJ5vi23f8Ktl/OeA08K7mA9z34FSC
 KEEIYrCsYmm/ICKXaKJHouSfR1IH9D4lXQqBhjpd+JgaPErKC12D3Kv7CdZ2iKh0oYH1
 mDiA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/A0rEqw2wNTs2F89DG/Ogpnd+tChct/EWoy1Gq7lryeepwuq2pj76fm8Gc8bmxYRcuglDVzV2oGnRB@nongnu.org
X-Gm-Message-State: AOJu0YyaGpuWJNctyHGWWVWDO/g7nA+sOZBj7omnNGPoYu+TF4sHzXo2
 y6WtmNDDJt+n0bQOGGpb+9qW7QoFl0cxyoHgpdEgUIQ6E6iMyl6McLmODSUg0+HYxhviy8SfzV5
 BXh5l/6xj375rWS4HzEDJdAkLTwTmOs5eUIqLEagoE4ZbjnIfHh9dD5JMJUiBeoRnZkkF
X-Gm-Gg: Acq92OEydVIxK/fKeCGqsb2rPz1GRyTpFxSRwPqUBPCDYIfEt1y+DPKxFKR7305eHmj
 SfCBKlFGIT5kliG30bnzeCoCb3aPCTh3bayWmGDMw4b+VNWw6VEvJSTD9GIkdh0KAhYbHSjnzm1
 E1weEwQpZnTdd4rfdrNTZP84JCJ83CA+LazkahbyEufkKLGYX+J5uixnLgHa9cWr97xjt5D/xo/
 S5h3qCdpRihDjiT0Uh6vU8o6mvd49qNfSCUfSs55ttNLMNNapqXQMa0tzueLk3LvHApaQsJY+JG
 Y7gPlcfYgwgzq988bUi4OdQNE8S7HuMx9IRuqQnAK07W20iMs+3dbYiFWDrID18fWM80hAPrpi1
 ZpTtBHk0t917Dbdbb1c9fhG8sICHRan7nOuh8cQo4d1+XJrUGqG0aHuEFJZB+sOov9b2lKLCp5R
 rZyz+XaPzA7rGrCA==
X-Received: by 2002:a05:7300:aa8c:b0:2f9:c83:19f with SMTP id
 5a478bee46e88-3044911addbmr2927949eec.31.1779494014482; 
 Fri, 22 May 2026 16:53:34 -0700 (PDT)
X-Received: by 2002:a05:7300:aa8c:b0:2f9:c83:19f with SMTP id
 5a478bee46e88-3044911addbmr2927936eec.31.1779494013931; 
 Fri, 22 May 2026 16:53:33 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30451ef3273sm3065053eec.2.2026.05.22.16.53.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 16:53:33 -0700 (PDT)
Message-ID: <5630dc00-e325-403c-bd5d-33d02df0c7d9@oss.qualcomm.com>
Date: Fri, 22 May 2026 16:53:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 25/37] bsd-user: Add cpu_copy and make init_task_state
 non-static
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Stacey Son <sson@FreeBSD.org>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
 <20260518-misc-2026q2-v2-25-6c16fe448301@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260518-misc-2026q2-v2-25-6c16fe448301@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDIzOSBTYWx0ZWRfXxx+fIb3YguZa
 mwDJBh3W1t+J5eKJ/3DeiMUUI6KY18dsA17kg76AtsIZ/URBmrEINrmwgbrgn8E3RmS7cDy5RkX
 9OQq82lz6e55r48pX4FNQBe+ruHmaO7nhGmbw+WJVu4GsNZQJc3vNVqus4QaxLnOLpK7hqoeJCN
 1d13pnsC08tO2+p+Om9puxwmUxvfIIK2MZT6/zYvh1B0S948RnZIlg81RlUxp5BG5l8xBsviM7g
 u32474Wj8ViCNwHztxdGrfKDjDpKX5k3pmot1Mej6uJ58uxSB4zOtTuaLIASouoyR4kFhff5w+y
 HhwuZRA9mVqDo2CAlryBTZk3wdfhCqZ/cTL1MJlwSOPOGkGYnw1PwMA6z4k0ZZEqBX/cxTlNLU1
 pWFM1J8YvQMwzM9qzsezLh8c5Lx/h8HXbZ6dUHOVnmPsyjLDuh6FWl+copgzPwv0lY0yCcoJVay
 MqtqLUs4vlNSovVfP7A==
X-Proofpoint-ORIG-GUID: ypMSAPGzkmj6z35PgheJ2pgQknIvsVBW
X-Authority-Analysis: v=2.4 cv=d8fFDxjE c=1 sm=1 tr=0 ts=6a10ec7f cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=6I5d2MoRAAAA:8 a=7Qk2ozbKAAAA:8 a=EUspDBNiAAAA:8 a=cVYly7N4wubxOb7dmMgA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=bBxd6f-gb0O0v-kibOvt:22
 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-GUID: ypMSAPGzkmj6z35PgheJ2pgQknIvsVBW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220239
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/18/2026 2:27 PM, Warner Losh wrote:
> Add cpu_copy() function for thread creation support and make
> init_task_state() non-static so it can be called from os-thread.c.
> Move cpu_type to file scope so cpu_copy() can access it.
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> Assisted-by: Claude Opus 4.6 (1M context)
> ---
>  bsd-user/main.c | 32 ++++++++++++++++++++++++++++++--
>  bsd-user/qemu.h |  1 +
>  2 files changed, 31 insertions(+), 2 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

