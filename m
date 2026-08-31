Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4881FC61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 10:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0ywB-0007iU-D2; Mon, 31 Aug 2026 06:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0yw6-0007i6-AQ
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 06:08:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0yw4-0002Of-OI
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 06:08:18 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V8vmMd3302968
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 10:08:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7zWdv7cUnYT3obPhLTChhJrjSEx1QVaS7ZcgFj3olUA=; b=T21z3hjLuCH10lmM
 Jsl2my6nerwUAcf/ZN3W6nqo6FEkYOcSsOd6fOqPM6+mIKMOXid89UG+l122ke6S
 Oj5Ky2Ir+5O+Xv9OVn4YmoEDctUZlOa5OqDdmhzu6zc7kF6a+Gq3NPZMp+IZhhI5
 fl0Dwmp2AnORx5buxox+lMywCFzl7cTHwi0SUZTB4RtOcscr7KBxCQtMjECBNkRg
 6jMz7++9PVJNfYXh3ZcaSu9uPmvBNt7WMu8CVTFe648qM6cq/E5njrJ3cxtkdEEB
 D7SkI1PCQcCk3/Khj30oqBbi5oewIwTiRDzXNqfuPxh25QnPQnSXWlQ0dWfGlGAZ
 jWPXbA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd6jgg9n8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 10:08:15 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-930b571432fso470347685a.0
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 03:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788170895; x=1788775695; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7zWdv7cUnYT3obPhLTChhJrjSEx1QVaS7ZcgFj3olUA=;
 b=JhnL/ZXY1FmmZS1N4sSDAYa33BwYh5ediKzYwHbdNS5PAZr0CRaDUymXHidmzLn061
 N2fYnmi8A/HeDDQyxJe8I6/D+WmrrsB038L+UgMjJN2skx7LiefSgw9Aok20WhggNIB6
 UkkQmGy7LWve35zCTzNZFT0/Izc57wu7ht192zXovDii3XAQf1jhIWzuFD5887ZOcxJd
 S/IogB7dFAtUvLwxStMyLsYYRYS3TUUaL+jmNcIK+0o+3e2Y/01IH4fYYm7tr2+fZzsH
 beEkflCajzg6xBTocG9zF8JiQFPNgNMfpjtC8CLqcdzrcMPdZDaq9+QLwoM9gw+WBBP3
 Gl0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788170895; x=1788775695;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7zWdv7cUnYT3obPhLTChhJrjSEx1QVaS7ZcgFj3olUA=;
 b=GSmWAh8Q2vWgdbiZk9TjCr3m7oZ/SIi2R2gLuNInilq2HWad1sd0aRfgMRSlhhXle9
 KWeabJCTQ7Y4PlySwy4KR3HHQt7O+u73lkY8I9EZU7ZJqNV65d7oM9KImRKWmYCHPZ2Y
 FFaiSWs/gTSKkh3TlXdK5jDtmM9+XXqe+95Pvqhr3DC6jEVXxJi2+V3DszTWJhJBgG2i
 ei9leVpdLLHXpqzbvb8M8YQMJODxK30vBQv/yEWGNcSaVL8UeyhULFejmxkYV9RbN8k6
 vrlMLrSMtyhMfsJMYvo9w79SGyBQrJ+TMqK+4dvHm/bDv/WQ5EN11X6EdnxXbWsdBKQ7
 EDBQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpJUdrE9VqOP02inVaq0ZsU4gBAQ931p22aV/y77i1KR3HvxR09f3ht+FWQK4TXK9I9wnFDo/LuTepL@nongnu.org
X-Gm-Message-State: AFuF++kCv7krxrg1UVDF4uavm7eAhHkznYFKh2XTo0VfTgbEPk2x51h3
 ElTpjyJqsN1BzEtcPxswRk4/FmJSjtBK3yTwoGhxo/jYackP2C51PvYb22h6ou7fWVPbZm5KXuL
 g443vzG1P5nUdhjyvEaRr6HN6FjBMl5Yc7dkFWH57+nisWTcTkhbj4EhXmg==
X-Gm-Gg: AR+sD12WCehs5YEZQ91FhzteYI4kOTBqU7r7d35LvN7v1j3xtQt9gT5MFHernmTpNeo
 d+Cvfals6mHzPCFZsaXZRENcbGA4Ngzzzm3/VzxzTJtKVJ9uYSmPH1vnWKmTBV64ZloDNvy43GC
 xtmKfkSXi6I06qdcTRVRYE/o2+h3d3qXtdHYtHCYCQ7zKet86IgFkanRz64BOD+kjG53yBJWVkd
 ln0kFTZERRje2DYoh3lfILHAD+xyJRcA0BBZCyFaNTEI/z33QhUalI+1frUtPTRloMs8GKsyZTy
 nvmhajCIx/XRFrLdFo9xSQJODNg3lsrr8KMOVzPjdRFPSg7lRKGUGP+qc4FIegAHwmPjWqv7Ebj
 vucnUkycK2GwzGWINcdSQPNWOIhzIjJKujw==
X-Received: by 2002:a05:620a:1787:b0:939:957:ed2a with SMTP id
 af79cd13be357-93936cca294mr647647785a.15.1788170894742; 
 Mon, 31 Aug 2026 03:08:14 -0700 (PDT)
X-Received: by 2002:a05:620a:1787:b0:939:957:ed2a with SMTP id
 af79cd13be357-93936cca294mr647643885a.15.1788170894321; 
 Mon, 31 Aug 2026 03:08:14 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb2794dsm22589235f8f.25.2026.08.31.03.08.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2026 03:08:06 -0700 (PDT)
Message-ID: <7907e4e8-6c1b-41a1-929c-8e680bd2992f@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 12:08:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] hw/cxl: add cxl_destroy_mailbox_t3() as the
 mailbox teardown counterpart
Content-Language: en-US
To: Junjie Cao <junjie.cao@intel.com>, qemu-devel@nongnu.org
Cc: jic23@kernel.org, linux-cxl@vger.kernel.org, qemu-stable@nongnu.org
References: <20260729144645.1552511-1-junjie.cao@intel.com>
 <20260729144645.1552511-5-junjie.cao@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260729144645.1552511-5-junjie.cao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 4Fa8Iy6wzWfbjwTNDn6r9FNX4KHANPR2
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA4NyBTYWx0ZWRfX+Iq/n2VSkWeo
 6yRxU7im5uldLHWzR0ti2VxZBKVVEawSBjRAdBrGElspQGaquzP9dhUKsyCgoXfJC5RP4BFxS3L
 qRAAXSh1fTbgZVen6LzlNECml0/My+A=
X-Proofpoint-ORIG-GUID: 4Fa8Iy6wzWfbjwTNDn6r9FNX4KHANPR2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA4NyBTYWx0ZWRfX1T4+6DRrnoof
 v6NOJM/p0IKWm5ser9p24CMGnOVCiqoHJK51GUP/EyK444SvNmaZ8VnlQvWWSv0wUjEigGHPcX+
 Tf1+0uGoEVkKtcTxqqE8QP+MharfdwQ3wtYqfJXYsAIAaxvT2x/X7FB275x2nm2XEDhSfVTjRJW
 gYKURKkplmxJORNxKrGAi4+f3Ei7eXiN3CaZtatE70CKXd+9Cl4DwKuAPnfpz0zEGZE1dSAzs4q
 JT6aGwx3s8rJOG0cTodT6wt6j0WtsviW+NmHGONlD62XapKuSmkyFnXNu3xXcHU7M68/e0yIh3a
 t6m04u4v9sIvcwhIqPYxYcA2EZF2A+hLz3EXzoKn+jj7jAay74welmn6zQvr8rH+c+v/l6xdGWq
 nYy6Av4PFhyd+jtcDPyQUb4IaKG0VrzdgfLal675wh4JNj7QFlDaSpHAfqnOvtQX1D6Ix2utqKY
 hlbc53H818DbRe76Odw==
X-Authority-Analysis: v=2.4 cv=YsY/gYYX c=1 sm=1 tr=0 ts=6a95528f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=QyXUC8HyAAAA:8 a=lJrOWJkMPCPpVJRVPmIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310087
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

On 29/7/26 16:46, Junjie Cao wrote:
> The primary CCI teardown is open-coded, guarded by .initialized, at
> the two places that need it: the reset path (before
> cxl_device_register_init_t3() brings the mailbox back up) and
> ct3_exit().
> 
> Factor it into cxl_destroy_mailbox_t3(), the teardown counterpart of
> cxl_initialize_mailbox_t3(), keeping the .initialized guard inside the
> helper: the primary CCI is only brought up from the reset path, so the
> first reset after realize and an unrealize before any reset must both
> skip the teardown.
> 
> No functional change.
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Signed-off-by: Junjie Cao <junjie.cao@intel.com>
> ---
>   hw/cxl/cxl-mailbox-utils.c  | 7 +++++++
>   hw/mem/cxl_type3.c          | 8 ++------
>   include/hw/cxl/cxl_device.h | 1 +
>   3 files changed, 10 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

