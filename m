Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F96BCC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 12:18:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGbS7-0000yy-PN; Tue, 13 Oct 2026 08:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xGbRy-0000vY-2r
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 08:17:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xGbRt-0004bN-JN
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 08:17:43 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D8dqBm302843
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 12:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qzL6clrGc/FXST19p99PQ1HxTrkjSAovbWaqXCkP7jU=; b=dln6bPsAsOAkmKco
 qRRvvuV9ZsF4pbZT0XZGTOH0rAV5UueJnHXtp4gOgEz+q3XoDB8o/JcExBjd52dw
 1nHNlFbwB7bNKGCCZju77KVWoUz3LSzIk6MyCKIewilNEj0jtZor7XxrRNmdpWCB
 bEWF94KZ+pVzS1PLGpSDe+eg64rzyzofbi+5KwUa+HFoDWTVFwez7+QWmSjVWoR3
 z2SrWDi6mxJRiH9GS/D1S2KRwXdOTPe0YRUztOzGIcoRpc7TMmEWj9pDrNBBkbfc
 2gVqyQ3x1tYnVHfpnuAJOehYL/TVE0VvHmu11Kc/jRhRtW+LBaHReDtBcgaq00pV
 Lct6NQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h98sqatwf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 12:17:39 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93a082c014aso642497985a.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 05:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791893859; x=1792498659; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qzL6clrGc/FXST19p99PQ1HxTrkjSAovbWaqXCkP7jU=;
 b=CF0PO4goVGwHU5XrFHyW4Kn86jV1+G2PQ+8EZZtnFx44r1KASyG7fK0+EJ0MSLKEf1
 qWYWpSu6ojiza7zUAMQaJIBN2VSSVjEcEVx4k3QgpIykNU8xYJuGKsT9D/4gEUqr1JNL
 xklIZW0Y6YqiJ4t4EKOy0w6D2uxsbCiBpSYVH2ln1sfrjAoCl4pkIX990qF77RTJQbZj
 jL6mP0IfgnV4IEHDZ0Sgdwq7Jf7w4Z9k+P2kjDIXptUWlxCTcdSeETCH1AS8nbbLHAQF
 E81EDH815rBlblR4580XKGILjQ7Y68OvO22GO/E1GKRPQqGHGafuWOQ0qDOXRxjeiljC
 +Ybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791893859; x=1792498659;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qzL6clrGc/FXST19p99PQ1HxTrkjSAovbWaqXCkP7jU=;
 b=SxdgaccEPkRnPayN2a55LoYhNY6VWoMdwrxzaN5m95KT3IQZQnbEeE2jeqRZ/O2qcH
 sheFT4eegk7Lo0rPzJGtV3GfV/2tsUaIQlX1VNUNVjd3CKMJQsdrZCocWSPMUCZUqr3G
 EvZPPJ+O1JTu88/vp5u3y+aoQpWi0VueR2190PNR/KtueCB7UNIEsaTgFQH9kUvWmvf9
 oewgCUrS4Z/1rwV9mSzV3Cxws2fw2CPOKTxyrQFwezvzv8KVcEIbMW+cVtrwAVMNihsy
 bpol2SrhTQE1FePCfEZ1t1kHStHpRgJzvRNnCKNl9sO193bqPiD07CvGKJidLUMEKtmC
 D80A==
X-Forwarded-Encrypted: i=1;
 AKwUvByqwuylvQoMmL5OAXOfXMp8zPTuj+2cR3TZF5igTaffpYMWccT8ivc0wai+xS3hYL50HjsdV0WoHo03@nongnu.org
X-Gm-Message-State: AFq9FYJ1QRHXvkayfgsUI4R6Q6/avukQgk9VN0kWLJG9+2pMb6G5rL8W
 v/E6HsPSp1njgrWDYFl4ird2fXVP7ouxnED56oc3SL1Y5A2dOKTzGJSXtiATKwe9KX+AKQOc+jk
 xRK3JrOtKg5t/bHnxbuX2Ohyb57S1kI6GDtL/ZKxd/Txl2ta8avjdPtqubw==
X-Gm-Gg: AYBFou03JaVATR7EBbtBciWNyInuLYKF/ILe4yy2aXQFzu0D4L4LrheABvJyRNqDl9w
 t94NfM9BnDEWWPIgIjIOlFZgBT2DrI4fAUqw5TUUZnoxjpyv/Kq4Ia6nxXlowYHb42bxhpSdBsY
 LQ1/IhKTdaz5JaEAa9tq6lZVCWC+B/6X3wgNwDaHo/6os/2vPPuXUXgc2UFXdhtjt8eEWqA3ISJ
 vqH1zSQmhAiERvYySV4iQBBSHxeAGmuN8JWIssZJq8B1K8TMjFGvkSxt3Hbvl0O9YhJaHegFkqZ
 dTyiE/J/GTnYtdFzOoDRg/J5KIoZUGVSyb93T25V0ba7EIQxKSXnprovXyzozsqwZ3BPbohitBK
 KpUzRL4pz84Tqysw4euGWO5XlTr2CI2Y2Gw==
X-Received: by 2002:a05:620a:2707:b0:93b:d88b:ee01 with SMTP id
 af79cd13be357-93eb9688d1fmr2008188285a.34.1791893859099; 
 Tue, 13 Oct 2026 05:17:39 -0700 (PDT)
X-Received: by 2002:a05:620a:2707:b0:93b:d88b:ee01 with SMTP id
 af79cd13be357-93eb9688d1fmr2008183685a.34.1791893858537; 
 Tue, 13 Oct 2026 05:17:38 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf135fasm318856355e9.5.2026.10.13.05.17.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 05:17:37 -0700 (PDT)
Message-ID: <ac549d9f-de2d-4cf0-b41c-21b975b6c3e5@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 14:17:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iotests: add --quiet arg to hide env variable dump
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
References: <20260623160611.2347282-1-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260623160611.2347282-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0OCBTYWx0ZWRfXxDNMRxeWvXWy
 kupDGlFombZW3LSiwoxQJoqtTyoc/7P1okA4WmqiBdYx3xvosAz/BVEPhCv2MwawIm1/Y9OQs/L
 FLzgqpuVJ67MYkAKeCLKkPQ5ChClodqzXchSO15gDGrb/2X8F97/cTsaPXZjUVhFGKn2dCAZ8JB
 QfpDooqKLP4IWg+IxlLiCivwPaagbYEca7942fRAI1gVPVv2CR/4RJk+sDugDPUQ1Vx52T/Zcua
 DKJnNmnU52biKgHIsx5ZwFkCqMTqvvzWPmqjG0RgGFq+vqyjp8mxpiOizd6sIjU3cUvlW9dz/ZQ
 yjwbICdTZOzAsee/V0JcFTMV4WXm+rtmD4OTqtjLT0hVjWWHdPRPsScIv6nb+DxKggdkZydf49g
 UurMIQqlxRAkcm2X+rSC36MaeHYlJyMYkKA6rvQO8OeGhEuKMIDB7hrFvoOizhNQt+dFI4XgOfr
 urT4S/i0JayjRkyGHDg==
X-Authority-Analysis: v=2.4 cv=JN+uIMKb c=1 sm=1 tr=0 ts=6ace2163 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0OCBTYWx0ZWRfX5qrW+OOFlJ0r
 +OGUgcc+Bbn8PW4deTjpDmwDstKr2IKbAg357AcgTEFsdOCcoYVpREct0QI2n2j//2q35RQL5Xo
 3zqaTvAnTUStzPpgi9E8qWpFE67U3Ww=
X-Proofpoint-ORIG-GUID: oVhpLfz1anlP4naaKSAWT66qLXi9YBV-
X-Proofpoint-GUID: oVhpLfz1anlP4naaKSAWT66qLXi9YBV-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130048
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

On 23/6/26 18:06, Daniel P. BerrangÃ© wrote:
> Every test run dumps a long list of environment variable settings.
> While this is often useful, if you are trying to reproduce a bug
> while repeatedly running a single test it can be quiet noisy. Add
> a --quiet flag to 'check' which allows the env variable dump to
> be hidden.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/qemu-iotests/check         | 4 +++-
>   tests/qemu-iotests/testrunner.py | 7 ++++---
>   2 files changed, 7 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

