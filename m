Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03805CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 14:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEShX-0004It-V3; Wed, 07 Oct 2026 10:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xESgh-00042s-Rm
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 10:32:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xESgf-000133-SI
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 10:32:07 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697BV0fY3686734
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 14:32:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 n2aFQ8F3xbO5dk6Bqq8k1fUTZwLHFkTXw0FZBQcbYPw=; b=YLYbkioZaqOGnPla
 Gd9jpS4e7CJwKNaoxtfIEWyg2YffeZxlH2r2CFXs3LbfYVe2DjiFUcYjW/PdpYPv
 wo9WeJV5ie+R6OWIXV09FltuX8YeZenQsKH37v6AXE38SaUtzO/QS1WYupP+jqxU
 AehpcPAqvlg23HldL5aeiqydMeNWAALei2dqFbNfK5hVsMuie8WYDtlKPbdZCmMN
 EF1j6qgISLYctp9/+0oeYqSl85DvwhpN6YJu0Y14lnHRw/adc2ddRdL9zmXVfCXg
 toVsBTRNsE4g8gXyOCl0NIMR6bwMisjrb65Oqn2U177DWPUfhYD5oXqs8we1p1Ij
 0h4fsA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5mgr8uj7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 14:32:04 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3510a481ae9so7942495eec.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 07:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791383523; x=1791988323; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=n2aFQ8F3xbO5dk6Bqq8k1fUTZwLHFkTXw0FZBQcbYPw=;
 b=Ot0wv7BqBO2KH22z9rnboQ6eky7M+dRBsJG79KJWLG2kWxBKlChKXosRet4OjpcPBM
 VQ7Qd8fMBmy5yw1UONgtwiPShT0glAxcFWcSspXtpVLhZz+HFcK+lsXvcWw0m8xakbaO
 gJXcuk6ZRWQfo9d+qtMY8XJTgg5KGjUKdn5oJoOmRfoRk36LPThODeDu7K+DBxoKCNbt
 xR4RYa8WhnNaiwLHrcohGDi7h0gMWnZ3GOZIA5tGz2rVfNXWi6CRH/1Vcm7Evvo7WBa7
 IPLVyXMEEewSqG2j7dO0AE3CVgwu6dnwMxEia0bYeoSmsAHRafIXq+w284KxCyHvNBIW
 TFvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791383523; x=1791988323;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n2aFQ8F3xbO5dk6Bqq8k1fUTZwLHFkTXw0FZBQcbYPw=;
 b=lZ85CGr6ojoe8igNbrc5lVIZk5vulLHu5SnSp1puxHmhEMi/EMDFS026McJssIEhL8
 +4YELXOquYQpMeUvgIVkrv+LGQnWT0cAG/sPphfNpOemZJONc6BfLMaDRg74hVN0RyIl
 Lg296aWa7QAym9J35DoHOT7aN5Savl3CGZFI6YRhSiiTg0s1uuRXOjgjHlCyQqp7db43
 9SJJs2g6psgVvGwoZzQEDKO+jkNr7xoy6/VXxAYfbh9yFWpsUBBxUZ3NkSe+mTsN0gty
 VXIsHwSTqsS7VXQcHlDfYDKGSVtbjC/bOH5Lwi0NozqhyAMl8XDC4IvjAo2e3nqT9h6i
 mGZg==
X-Gm-Message-State: AFq9FYIq2YkkI1k53Gp6udO2bKh3qAF3sahCdsh3py/Wn9ey/Nfti5w5
 IeeMBoSh5pKf8IWhB22R4kk09liXR7JXx1rTPEyDrEnjnrU1m+PlOfJPI7Z20OZ1oqJetDNGHUK
 qMIouNPG+Slcb+dmOFyLUMiB9ngEAki3z9AgI0cs2UuYlMWrSoe6wNUVZ8w==
X-Gm-Gg: AYBFou1tWf5sb75kKPtkmnPg0tzkMJhykv1eYKiSnexrMSzuY23/8yDEPXmNio/ox8H
 MYhm4sB1Qy339yblgpUWTv6K3IZWeKV06bHq7HDCzRRNKH3OMMOTRP6qoy6yoEZGGE7OiVCXbf6
 rcabKWRWQPZO8s22/vLCXhbv2O/AW4mKK/ZrxjGvGcQuLN7fdBkKenNsyAbtcQuQS3q6K0gp3Kq
 5PJsTXtD86Ed7KVV1hI52Q8ykXTv/niLiwTXDBnGhVCcQxnSdikZTSkPNzsmfI+ZsV2Z4fwi0Pi
 AzjKnwjfGTajrfbIsBdd6aG+Jw0Kaos27OigOvQOpcmG0v1b50EtN5qEvjaKyzGvEdYt96l6sCl
 jB2St7sQ/qHsJxjcXa4fXu2okfx5K5LwPA2efGC1hlAdro0zUpgNgLhGnC4pBibWUYnRGpw==
X-Received: by 2002:a05:7300:cc96:b0:341:1823:6a50 with SMTP id
 5a478bee46e88-3515dda875fmr2488091eec.15.1791383522984; 
 Wed, 07 Oct 2026 07:32:02 -0700 (PDT)
X-Received: by 2002:a05:7300:cc96:b0:341:1823:6a50 with SMTP id
 5a478bee46e88-3515dda875fmr2488012eec.15.1791383521838; 
 Wed, 07 Oct 2026 07:32:01 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3515af67000sm8058017eec.17.2026.10.07.07.32.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 07:32:01 -0700 (PDT)
Message-ID: <80371106-d600-48f7-bd6e-95cb41764d54@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 07:32:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] meson.build: export TARGET_ARCH_VARIANT in target
 config
To: luoyonggang@gmail.com
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20261006182558.151956-1-pierrick.bouvier@oss.qualcomm.com>
 <20261006182558.151956-2-pierrick.bouvier@oss.qualcomm.com>
 <CAE2XoE_6L6vkjjDM5LfXpy34-CP=4iJvAQK72qeB06TgvKPsSg@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAE2XoE_6L6vkjjDM5LfXpy34-CP=4iJvAQK72qeB06TgvKPsSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA1NyBTYWx0ZWRfX5uCY9jjZLV8/
 wDQTM5D7WQlkV94gJPLOma8HFbBdgATw+dIFdA8C+xbf6TEIiPQJIR3ziwj/HVsllhj4xlOJ/iL
 EzckBDS2sOmBiIhRPfArMqmwAOYIUd9iV/qtcMViA1iEn/W/CGkJ9+d8r3jEnbXWv5Y1izTihnV
 UGvhKmUgedybqRVb9uG6L+mzl6R2jcbL0kL0EZxTiJvgljCjTy72PBhkSRCCmoiGOKzf4xDu08i
 Drhccdzxo7rKAhvRxov0xvmzaJkTBcvX2b0T271FyZaqONmQAzUr2Qr+2Cj5Sy3w2nThmShagfm
 ob0/jwfk4KqC6QUctz2uENIMSAh5Ggj8rY/leETDlgITZRppNOvwt1JjaDFnEOjLpnR4wxY24cf
 8g+BxFnWFBc1CG58HNUdfty5mPRrIQkFlxuwycjqfjCgPLpmVZIVx4Y2vcHycJS/Y3cSn7vjXyo
 x9li+1/saClK3bCSxwg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA1NyBTYWx0ZWRfX+hG0VdB67vs5
 aHQE9wg7D8GUsKPUUhAnY2CR0VO66SPvfq/MUGD8ZN+GvAhyiduD/VtUAtKk35NETJtg57dwkmk
 OPxRMRHvViG9//EI1YlocwNdb7IbORk=
X-Proofpoint-ORIG-GUID: QzyUfldmuzmmI1UjTd88D8vYLC9c3mP_
X-Proofpoint-GUID: QzyUfldmuzmmI1UjTd88D8vYLC9c3mP_
X-Authority-Analysis: v=2.4 cv=OYkNnRTY c=1 sm=1 tr=0 ts=6ac657e4 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=p0WdMEafAAAA:8 a=MpWPnj8YO7y9ma9nE5oA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070057
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

On 10/7/2026 2:27 AM, Yonggang Luo wrote:
> Why not close: https://gitlab.com/qemu-project/qemu/-/work_items/4640,
> I'll close that directly.
>

Thanks, I didn't see this work item.
Even though it's closed, I'll add the fixed tag to current commit.

Thanks,
Pierrick

