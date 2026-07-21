Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1500C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 20:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmGul-00060O-JB; Tue, 21 Jul 2026 16:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmGuM-0005yE-Kj
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 16:17:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmGuI-0003cV-D5
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 16:17:39 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LHRM9L2376854
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 20:17:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BYpTBAWvrRi2+vPe+KSJH7aeXq2sKsZ1x0fX6iCMMPk=; b=jt5QI0GlhtYymTZu
 bek6DYhv7w8Se9rHFy4I7Llfc9klknbkBim3p6h1tnHFkDstIN4e7mDdvvRtxHRJ
 Mgfg+iz6af5nE6u6HWQNnw3/3g2Ymo78E14yxd+sFiLqoz7HVjwx31RN5F6OfEvY
 28TxN/b+9BpkjCeRTfSex9fNWCMf34qTMhJ9pxL7px77R4yKUxj6ibpk11yhUdxy
 S89lCKRpdW75FBKKMmUohYoc2eWmU3e8Tshqy07hMfPxh1v2dHDIj/b51YthSBSz
 ETyb09XMDvcdxFEADiIpxjuflUqnoudYDo4IHL8SZ3Q2QaN67USuyWuFp/ONM2GI
 fPMXNw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd6a8qhs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 20:17:36 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c110a3b6aso135291141cf.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 13:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784665056; x=1785269856; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BYpTBAWvrRi2+vPe+KSJH7aeXq2sKsZ1x0fX6iCMMPk=;
 b=avW2Bf22fhW4Ba9ggNQhpirnVlBmjmnqo874G9AKKwGOy8o9cObcyaVC+irDeqmiBd
 w0Zltg2C/RDfv6lIdel/HEO5i36IoDQPlIS0kvXoR3yucb/ztf16UOozJHsdWqT4FKFc
 kEAYEqllFNcCQukJokVjk5FBLXu0PPg4cd0lpsSpWNKshTHNVU0V3QN3BCKBhCbMRFgF
 QK98FIbvN20MpYTQ0rJlX4SdyxJ3ZInXdkUWZUJaegr1sg7rHzGR2SeD4cHiUaP3DZTg
 9fEVFcTFHA32cttnWeBEBL1UukWuzY3NlqUUagCkJY0a+QXkn8pMg6fN8E+Ay63e/IPY
 MsrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784665056; x=1785269856;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BYpTBAWvrRi2+vPe+KSJH7aeXq2sKsZ1x0fX6iCMMPk=;
 b=T+yxLe5RLDzQzPGiKfI9yEH0VKrlqBSpwZLC1CdvGw0LgiwCjFmvj65vGIcrwGvwpN
 kB4Hxz8Hnpyd65J+PX7exx53RSnV5oZpiI8G0pnX8YxB5A5safsMAUpKTM4HJPrABtoo
 qfrX4zYU3l2dgcRmK8PwOcTavZEzt0W6NR+ahYgZynoy76FiU9YcFh7KXM592n5jVrHT
 q13Y83w+wwACBEgjorIwqv0NA8/2TPdD5Y2X5AtNOQft2Qu2A26CUnWrouA/8gETwOvo
 EkuOJtvx2GGJtirO006rkW9Kce+jHrvm1iemaFFViwhqh+XSUl31PBLSLR2YcupUEvGA
 CxEw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoY0xlYWynnY9YK8Ylc+i10e32/GihdNfYpzkLACJ4h5Fk5So+mFhNUPihty21fxuifV+CGsR71/Wdv@nongnu.org
X-Gm-Message-State: AOJu0Yxt9rdVCgTBNw2VK3eUmv9x9r+3yLp3UzTMiK7d+B/HoMrd/9/3
 y2PG9KCgfnFpAQT1+pCxAxoBodUDN+zX2mh4HcyeQphdv58BxT1qYinA6UR32ZzI8uQqkI8Kt8b
 1SU9Q9GYVwuc4/E9kOpp1cmZfESKSVFJWuiONLx9wmYUDYzsnQjcV43E7Hw==
X-Gm-Gg: AfdE7ckIG0qDH2b0Es2hFKJwy3ApKP+l1Alo/ys6iUQ/iSXOkEfvJgcCiJ1VrGcnCx9
 Dj1kTkog+w29eYmYg9Gv2Ir+dIMLWKIh79rbW8hzW768Jy86r/cLMhMBXoTcHd19+iQNVeW3pCd
 J3NacS/6oXebZM9dQWT/WJvNWrlX2LtgNkTNlr5y+MfLBu8uVaqg1WW1sSGM3d5as25z8GrsAkO
 qF+mqejFJ3x7mDzun42ROugbKDeV2+hZKGs08GYKP6kNidx9Pq3FAT7i3CdZhVJ1wmDtUTYZ26t
 48UkldmNFn9+4MUkosHVSVNUrmQbckswQCh1VDRyQorLJIWxChyOpzn5eESIvthGFBuRiFhbNUz
 SKdZdr3sNvxErRNo//e3QCY8PgfTcqCDf/1feBLehRfTHJGGZkkA=
X-Received: by 2002:a05:622a:1b21:b0:516:ed02:c85d with SMTP id
 d75a77b69052e-5213d2b6a70mr185028561cf.3.1784665056255; 
 Tue, 21 Jul 2026 13:17:36 -0700 (PDT)
X-Received: by 2002:a05:622a:1b21:b0:516:ed02:c85d with SMTP id
 d75a77b69052e-5213d2b6a70mr185028231cf.3.1784665055828; 
 Tue, 21 Jul 2026 13:17:35 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e49469sm43548360f8f.7.2026.07.21.13.17.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 13:17:34 -0700 (PDT)
Message-ID: <71fe3184-a5ad-4538-9e1b-dba8613e568b@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 22:17:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ui/vnc: remove redundant rows computation
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
References: <20260721152815.610844-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260721152815.610844-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDIxMCBTYWx0ZWRfX/d8ff1Wi7/4/
 NX3ghE56tDF9VU49pZrPfu4DLHXjjMfO7l22vdXHEFsBmiGJUa/eJVoZ0wqgdkjy3IfGSasMLWv
 vuqHSlgqoP7+vdWmhwbZc3xs4PWOJFVa4p1I07noUToAfgsIvdVGLJ8XbUxYjeujdilr1Mo+car
 E2XPlIxZOE+CRjBijmP0XlsFbMUii7K/GhOi9F4Ois0InyBvwTzVYnHnzDc1nAGyefotKDUGB3J
 hRQD5w+UtoPa1GPSD2ejIgtuJcDpYwl2xdo3jU9qUWTggKykr1qIuHdYnwOwD354vAHdMiOS4L1
 vjP5cqnHNnlKW1eewhJo9TowqgD97vT/fPy5+svMHxmRrdHBQfZRwCLh6UvUYQfGizyhQDADgEr
 KHuhfdA2POclP+DNNxiICLRP/ahoahbNexaZznQ92W1X+4e4BG2iG0r5sjTT+W9SbDeFX37IprK
 TzoQw7h9u67Wt1VWhbQ==
X-Proofpoint-GUID: Of9-ZKu294nsh5kkpQjbj_ENuHe8RXN3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDIxMCBTYWx0ZWRfX2vDkqTN+7JIY
 H4FcoXFurlkDZvQKVuqT21CpiALf8yBW1LAm8o7wL2JcgR07R8jh+FJmqj8BjC4cZRPp1H7JCKR
 RYF7AHx4tXkTlm2yHdxNxb+moAicXxo=
X-Authority-Analysis: v=2.4 cv=HvJG3UTS c=1 sm=1 tr=0 ts=6a5fd3e0 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=tEm9TFOKsLfuLxGdLa4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: Of9-ZKu294nsh5kkpQjbj_ENuHe8RXN3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210210
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 21/7/26 17:28, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> "rows" was already computed in an earlier commit 3543c2b855 ("ui/vnc:
> fix OOB write in vnc_refresh_lossy_rect").
> 
> Fixes: e650e4fe0f ("ui/vnc: fix out-of-bounds write in lossy refresh dirty marking")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/vnc.c | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

