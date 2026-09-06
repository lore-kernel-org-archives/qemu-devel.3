Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 796C3C79F99
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 22:30:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3LNu-00089j-M0; Sun, 06 Sep 2026 18:30:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x3LNo-00089E-U8
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 18:30:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x3LNn-0003ym-9j
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 18:30:40 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 686L9Haf3226769
 for <qemu-devel@nongnu.org>; Sun, 6 Sep 2026 22:30:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 T7+hjsdjeuo9ibCgRbgDRI2C873fyIJtwqFWCrkC/5Y=; b=Qi+EPKjng2JhKFCR
 HNTputdSo6ynYMrVdgL+Ip5EN/oBsGyAuWnHYBrApBJ0FO6jhqgKOQCoyJ0VtJdV
 GBvFie6Y9ULODrdyzObg3ybngWnBRK+kn+0HHVa7LH4sNEbmxcYGzSFEonr6Ekav
 13wSimX4jCE74aRV9j6mwRHjIGQBgNxQVjfxg65Dd6VRwR3k6Y85lHPuEBkEDDqu
 TM3UGG6mGMHEn+eaSm4+PKew3WYcqaEZCyb6tkd1E2BWRIW3HxiIfpORV8nUPaZl
 23xdvm8x/KiMrNB+cjCbfqGzPQ7w+B/Y69M83JW7hgYNkm6ggyUNww3RIncHKfQc
 xyvv+Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gg8sd4qd2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 06 Sep 2026 22:30:37 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9382f9430deso508339385a.1
 for <qemu-devel@nongnu.org>; Sun, 06 Sep 2026 15:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788733836; x=1789338636; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=T7+hjsdjeuo9ibCgRbgDRI2C873fyIJtwqFWCrkC/5Y=;
 b=cgtK1tnfv2jr9JtzEYDaCJzYb0LMaQpMYkGhxUt5b648bSfRXc1zwINgJcNPg2cHsy
 i3LWbyUkxOlkt/H0T89JKIMbHd7hC1a1UWPnkSIrqv9D7GYOGf0i3QVe/Df9EaYoIt0N
 0PXfsxMUVjRWnnnEDSbtR5OMbDK2dJP3ytctGCz0cDh4+fVQHiTsudswkhjR9qlQ54F7
 JmOf/s9jYJ5a6gtS/vev8lV+gxqzAlPWGrmw2eYu5SA6pUFeEBUf2ghC3VDuiak+SSKj
 bAd5bkmu3tDc1GwTNxOq2WqiWNzyFwxFPcbn2HeJ+8KrIM5kDANqCFRY82ebxslY2z+9
 NE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788733836; x=1789338636;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T7+hjsdjeuo9ibCgRbgDRI2C873fyIJtwqFWCrkC/5Y=;
 b=fy7pwxUxnuVnLF5hUJYRi3/2yQg/03rsD4gjHzH7joVzn2MaOlVGiAuZFpsJN0zUZd
 Q53MUk9/73s6dozps7sNpADUJa+JlOPKV8yS4DJrpDtPnJe28DnDEGt90dYEaVlYZl2j
 U1pAkOvojKbuoWPIYT/KRnj/wv2Uy0WapwQfZIT41jshW1gISexFai4K8C/7ddVYY5aD
 8AYyyKzYGTJUEBaoR2HiKkvmQdzFO4AlOSFTbr7mjcl/zovAO3il2mVH8qCMPJ6Kqj9Q
 7CwUnk36FBBmImjtsG8cYQIPEA1iqRkQ/51uQ3wK0I8CKTHXwZeFdR5OlcVqkPV/XPF4
 Uy7A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxOb0Fc4/Bw1n4laKvbMQNvfP5lzowWPwl8AdJ6I2bzscY1iFh8zj2oQffc87iryM20K38+QsqPGALI@nongnu.org
X-Gm-Message-State: AFuF++lCc54SdEN78ztefYdmBgGFUj6w4PapncZ8fOT0JQT4lO86LfpJ
 DVSwB9gDitNqNI8AQdVk1pbLMuRJR2fH9sV8XHn/bCvX0knX0xEFfytVOU2dYjXYR7m1rUHAMEo
 4MDcVdMYaRY3pwWQuZubth4Yk/yaMZuQ4iyS14Z21ScRmnje9CczawPNOjA==
X-Gm-Gg: AYBFou2c0Mz//3YUarEarHmkFzSrRL883wI8NKpDLKChc/0Dqb5uq7HKbukKFwddCcL
 WXeI1avbsrp6jZGZcxk6o/lSDWrpy9pcbNe+ZU7wvi0CEf+d5y2un55xNc1hgihWE+U6suN7+c0
 hZVnSyrybEzKB0JtENcwjP2sQei/K49nfT579kOHJbVC5iJx/QnBfuaAirra0cJrLnHi2trFGpi
 muHF4I0GYYZHwcRKS0AOtk7CGPxGxMaD8KmyMZ5rLAnGFluT9S4AL1bZGC2paOaYw1Tr0PmpLk5
 6qAUp4YwhOLscJbwSnlA+MCLd9/DCjb+hidSu9OVh+9/G6pkC6GeH+YtPboJa2xzWgnCDb7JZij
 Q1c5rkik5aygZ7PoSdVFomAKSRLHztLPLSkgdeUbdva9EUGYrETJh3gqAcYPlye+3cH8Hg3FFVR
 xCi784
X-Received: by 2002:a05:620a:7087:b0:939:7f87:ff22 with SMTP id
 af79cd13be357-9398045fd75mr2008461585a.36.1788733836475; 
 Sun, 06 Sep 2026 15:30:36 -0700 (PDT)
X-Received: by 2002:a05:620a:7087:b0:939:7f87:ff22 with SMTP id
 af79cd13be357-9398045fd75mr2008452285a.36.1788733835953; 
 Sun, 06 Sep 2026 15:30:35 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9397fba2c3esm734805085a.36.2026.09.06.15.30.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 06 Sep 2026 15:30:34 -0700 (PDT)
Message-ID: <75b264fc-779a-4ad7-a8a3-8b5c2a1312f9@oss.qualcomm.com>
Date: Sun, 6 Sep 2026 17:30:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] tests: fix qemu:func-hexagon-linters
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-arm@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Gerd Hoffman <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Jared Rossi <jrossi@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org
References: <20260906-nohmp-next-v1-0-2b21e63974f3@redhat.com>
 <20260906-nohmp-next-v1-1-2b21e63974f3@redhat.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20260906-nohmp-next-v1-1-2b21e63974f3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Y3xgfMX8380SYxcOlmx5kxd32Gdziyt_
X-Proofpoint-ORIG-GUID: Y3xgfMX8380SYxcOlmx5kxd32Gdziyt_
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA2MDI1MiBTYWx0ZWRfX0jUt/LtpJWGS
 4l0iSdvDuu1H7o6YeUQl1AL1g676ZOtOG7fTVCdF81DR2DoOChuXsmYGTftU6RZoZKaWIn0m1z/
 5i2EYhvCsNtr03qhicQOg1VfL6YF1b0=
X-Authority-Analysis: v=2.4 cv=dfmwG3Xe c=1 sm=1 tr=0 ts=6a9de98d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=L-hIhnrybQUmc0PeswwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA2MDI1MiBTYWx0ZWRfX8ZF54jWqi+0U
 gs66pH0njBubyS8Fe7a+WTDkhDDeqFawAomtgQLLRXy6vBFKfTybvU2Vlxk0V8VMrZXipG4OCx7
 Cn/NkTAUbqdmvaCvT8cgJH703NJKRTmsAfOuGi/wrrd5tSnQtYNjQmqmAD5hjEbixzylIinLInf
 zUCvIA3EiTWotAsPsOX8W1lx0Q2r/AZFIPj6AXEoJEkOYr/ra2VTCPdqFk49cXgdDsyOpezmaMH
 0qyI1KPBT/pdJFAbXUUdjDUV2ht0iYm4D0cpZAjyUhyxBiUt23HjtVkWNK0cZ10S9h5j1iMgRcJ
 pJyssFG8zur6VKkThmuHsHk1zwfrmfMVkAkLLwNyxToOSxqAaodlhNasUUrGEUSNPkzCrQwXBw+
 4OJ8TSmtIXmKUUHNGKLqlKZfeV0kFyVQGUpLm2vjcnXmBvFwd8U7M7Oih1CQ8tFmjqfbWOLOOjt
 5aufHvbj2bS3JpzUi6Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-06_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609060252
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


On 9/6/2026 3:53 AM, Marc-André Lureau wrote:
> Fix pylint W1514: unspecified-encoding
>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---


Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


>   tests/functional/hexagon/test_systests.py | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tests/functional/hexagon/test_systests.py b/tests/functional/hexagon/test_systests.py
> index f36e015f5021..4b0546e7ad30 100755
> --- a/tests/functional/hexagon/test_systests.py
> +++ b/tests/functional/hexagon/test_systests.py
> @@ -65,14 +65,14 @@ def test_fopen(self):
>           import tempfile
>           # The fopen binary has a short cmdline buffer; use a short path.
>           dummy = os.path.join(tempfile.gettempdir(), "qemu_fopen_test.so")
> -        with open(dummy, "w") as f:
> +        with open(dummy, "w", encoding="utf-8") as f:
>               f.write("valid\n")
>           self.run_exit_zero("fopen", "-append", dummy)
>   
>       def test_ftrunc(self):
>           """ftrunc truncates _testfile_ftrunc from 6 bytes to 1 byte."""
>           ftrunc_path = self.scratch_file("_testfile_ftrunc")
> -        with open(ftrunc_path, "w") as f:
> +        with open(ftrunc_path, "w", encoding="utf-8") as f:
>               f.write("valid\n")
>           # Sleep 1 s so mtime change is observable
>           time.sleep(1)
> @@ -83,7 +83,7 @@ def test_ftrunc(self):
>       def test_access(self):
>           """access checks R_OK|W_OK on _testfile_access."""
>           testfile = self.scratch_file("_testfile_access")
> -        with open(testfile, "w") as f:
> +        with open(testfile, "w", encoding="utf-8") as f:
>               f.write("valid\n")
>           self.run_exit_zero("access", "-append", testfile)
>   
>

