Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E98CD5BB8
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 23:11:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQZ0g-0002xm-3h; Fri, 22 May 2026 19:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQZ0e-0002xX-R1
 for qemu-devel@nongnu.org; Fri, 22 May 2026 19:10:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQZ0d-0005Mv-4j
 for qemu-devel@nongnu.org; Fri, 22 May 2026 19:10:28 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MDpWvF2125171
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 23:10:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uKp14X9RhmvJFLkw6I8h6+gmzVoViKQiQcCqk0KJwmk=; b=YqW+LZ4ZpNVQYhbb
 LGTl9QhEETgTxdUipB2zn5mnNQzP1kuxgQ+W/ELmaQ/u2nWJ+FJ2JzU5N/oy9SB0
 8eSOP1vA1VQov2VaSYNspH/bbxKuAF9s6ZWdssDO06tVFHi4PY9olaHLkn4m9R2p
 zXmpaghdYeEejo6e1yVed+qUzV+BS6qnefk6JaqPM1KDM4kmNxurJvuMyUZT8ICs
 xwP74mZElCOIFQgHKnhUgQcuh9xtuuly5BsBCeCjeaBPrGT7jDVTaRUKsvQ9ucge
 woBpL3yh6Vgok9t1NTYfDOaAQ7zkKoTLxd6jOtRbRPbbnw+eOVi0GTjQ/sgwB0ty
 D2mgHg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eard89y6y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 23:10:25 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2fe1cf409a1so12978575eec.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 16:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779491425; x=1780096225; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uKp14X9RhmvJFLkw6I8h6+gmzVoViKQiQcCqk0KJwmk=;
 b=WTiE9PLQA+oGhsf38QR8SZ3NwQnPz61BiRQS8EZXEq23xiOW3k64sfxN1vF/vTzoW9
 pd/5Y89pJaqhdB03XZ18ciBvrE4YuJSewtIC1Bq2Httk0R9jpkCSM+EB8wfKRkATWBKl
 pPGt4p9hZjpnEyXRGGCYTZ7HdRuYawrDUwvkGWkMjXQMpb7yvCWZfBHu9yanxX3Mw+a2
 298WoO37BUn0jDsr6IWqUapf4rZXYVLfQq8sHVM7x1kGr7y+vE9bNiagwG2QL0VV0ipJ
 VUtMB+Lf0DV4BV6L0S+AitkkHrj1JMT4igtUU2VAjzT6SM1CB0ywDkDJJaJYSreu1IzG
 M4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779491425; x=1780096225;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uKp14X9RhmvJFLkw6I8h6+gmzVoViKQiQcCqk0KJwmk=;
 b=SZZWQXtSxeSGvpA8+4PSsZ1unRZXV+TUfy8DB5tYV20QLhUcH96t/mE53UBc87h6Ms
 H/bpgV/6ZgUQrw5XwLRzeSehFVK/e9TCC+j9yiseOg9mdjoedL8Jt+Rb6Var27tSQXBQ
 N5SvpHQizPd8msjkUSowaUqPzmoW3EO+mJjHE3lRUQ1A87fdwvc4tY1iu9S2gHcAcygl
 9L52uUKdvhkDus9rJ163v2e6iSMzd1NiWpz2Aw0BgnyTf0MyckaUVEKDJuK5/ruuqYLf
 YKh9Cc9QAAOi8J6j5V17OTJ6A4bUKuubbRVebHTaS8T2VcNMPJzhd1oZtNnEp9uRxZoG
 iElQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9A2glqjJWkw90ubTvcAI7Utaa+0H++rft74psz99hl/8tgwB6E1WdFnuYv79t/fb3V4zQM0bWAvd6d@nongnu.org
X-Gm-Message-State: AOJu0YzYBmEFG9L9IuGeIi2w4RfgU6BmMz23jTPjUl0MujUwxJGetLQ6
 9i6QBUokvtY7+Wg90pnzqogxmSIL6iMNoGbvwuEGDRTgpnng10QPk3UkgTrjaCbFqP7FLfzmgNw
 C1Bq7fb/lPLEp+eHaKV0rk+XWLgKMqi1TBLdJbu2ckg/ZijAbFzCS/oo9IA==
X-Gm-Gg: Acq92OF1AjUSS1HbHhoecuisWvZjs5dPX3XafFsZxxzmdjRFl4pOezBp/MX2SpQkmuL
 Jm4ZynTSyUm2taZSLUrupaNBF/BGuktpGcTewIWQ6cY1oN0jsvX9ViWAiQv+wJfBCCeUDUzm8bt
 vvvoAq9Qb29KGgnQ8Wu6zq/r7MSFTzsQfjD1pLuBMGc2Aqs79a2V1knmWY3IM73wlAKTk8etm/o
 y5QS7A7fOK9sK8Qgdg5Mf30sUFMqmebDUYyG39ATvRto0SaHwQVQ5f+ZsbNUGwJw/inUVkCy8c9
 tSpG7cQyQulpQPa+0ou6FKwELYl7qFm3myEc2XhTDOjxkuUEvxTODP+2fZDEuoHsMmhjAl3fcbd
 pkTPgsxHLRtjACv13Ab8+vj+Kxieurv3E8piBYdd6wdmA/PQ/GDz1vnA06sw/I/et2mzQzoJ5HG
 le+91zuwLDJdkUaA==
X-Received: by 2002:a05:7300:e781:b0:2d9:5cd9:b8ff with SMTP id
 5a478bee46e88-3044904e131mr2735492eec.6.1779491424511; 
 Fri, 22 May 2026 16:10:24 -0700 (PDT)
X-Received: by 2002:a05:7300:e781:b0:2d9:5cd9:b8ff with SMTP id
 5a478bee46e88-3044904e131mr2735474eec.6.1779491423963; 
 Fri, 22 May 2026 16:10:23 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452255234sm2621712eec.20.2026.05.22.16.10.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 16:10:23 -0700 (PDT)
Message-ID: <4cc1edb5-aa2d-4121-a763-592cdf6a0aa3@oss.qualcomm.com>
Date: Fri, 22 May 2026 16:10:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/37] bsd-user: Add os-socket.h with sendrecvmsg and
 message structures
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Stacey Son <sson@FreeBSD.org>,
 =?UTF-8?Q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
 <20260518-misc-2026q2-v2-11-6c16fe448301@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260518-misc-2026q2-v2-11-6c16fe448301@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Fus1OWrq c=1 sm=1 tr=0 ts=6a10e261 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=6I5d2MoRAAAA:8 a=pGLkceISAAAA:8 a=7Qk2ozbKAAAA:8 a=EUspDBNiAAAA:8
 a=loXjT4mkNc2tbhBfqiIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-ORIG-GUID: 4wwWW5jk6Ne_iQL1dclVGpa0MhoD2m6V
X-Proofpoint-GUID: 4wwWW5jk6Ne_iQL1dclVGpa0MhoD2m6V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDIzMSBTYWx0ZWRfX6ZnBvm8609BY
 T9Yln5clW72M4+Bx0RJywy9JCd3hee1YjJs6x9w0H7SrukypYyzlK2a79vW7juEwpuSnzOv9eYW
 3NIdVitWcW3LjobhC4m6ZSEj0butaST6t8NqdMnaaNJ+SFvlw0AfuBRjMyBLq2jsBHkTUXKOoCO
 /eVgSGPteKPsZapZGqn5KxESW30dXGBUYFLvG4i9I5LqMxMrmWLgqE2bt4IG7aF4gxmgI4zam/s
 2wTqXd52tNBpdkuYAvJ5m0lPOTbhrmOz8dZQDCuazKw/7tfEh7kkfLHzhObrKMxGgXLD2llGKt2
 FTvw8jebj5+sp9cam12fckSTM9ZnJ6JoC+uIzZ5dc2BORecZ5fLM1EznbT0d4vO9BgSFe2tUPv4
 KaOVNqXCp7Wvji2e0n+ALtkv4dp4jgV2Z+pBYSNRTDIs9UHoOK4oJaAiP2jub9pmO7riyHKooZr
 Pq4bygPs8qiFFzn8zag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220231
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
> Add the first part of FreeBSD socket support: do_sendrecvmsg_locked
> and do_sendrecvmsg functions. Also add target_msghdr, target_cmsghdr,
> CMSG macros, target_ip_mreq, and target_ip_mreqn structures to
> syscall_defs.h.
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Mikaël Urankar <mikael.urankar@gmail.com>
> Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> Assisted-by: Claude Opus 4.6 (1M context)
> ---
>  bsd-user/freebsd/os-socket.h  | 142 ++++++++++++++++++++++++++++++++++++++++++
>  bsd-user/freebsd/os-syscall.c |   1 +
>  2 files changed, 143 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

