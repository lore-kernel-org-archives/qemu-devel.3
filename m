Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F4DC55184
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 15:44:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqupD-0003Tg-6G; Mon, 03 Aug 2026 11:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wqup8-0003TN-Q6
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 11:43:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wqup6-0005zl-LQ
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 11:43:30 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 673EC2kT1355162
 for <qemu-devel@nongnu.org>; Mon, 3 Aug 2026 15:43:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PsAGDFOalmANRUmQpq6erEVVHl2rEyxRaBSCENNWyfQ=; b=Kk76LKLrO/c2pZJR
 OyUzRsPjajb8LK5WxU135OWg0BNTaMwUUC/GamT8MLVOWz3GKkLxqdF2bFLWiN0d
 DB0D3BorPfpZy4Gh0rpR6LInPKD1S10u5X0ACQfSsBMB8yhclwYLJkXt+TrpVdSt
 m969FTvf2NfHUM/t1uWL36ZBD0Cu6VPC/G37iSN+SWK2RLgF9dg/8YP93Af7u36S
 BN/Pecd8amsPmLIN42TrCVK136bF4Jx44czyKh684TaC2EXh9xhEjQb4YCGpT5hX
 ouG8Q5wJop3/IPlDBRGr1Wu1as/Cuj3UTE999QemnCXy5AfBUSJKgoo5qbfOhoDK
 RGXxyQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftnrdab5u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 15:43:24 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8fdace20927so34367456d6.2
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 08:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785771803; x=1786376603; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PsAGDFOalmANRUmQpq6erEVVHl2rEyxRaBSCENNWyfQ=;
 b=DiZG8rCZXIxjpP6XwabkAf8wt+o3uL/FFtImN+5z1IGWeFTK90NwbK6P8xOWkeuSp6
 EuRGi5cl/q0vM0LcyCXqCZiro1grCeN9/HMP8T+bqq3xoTwjW1ZXlLWAUcPm/PbHpBSS
 qfYWn+XK3uxUCLuj6dP9aP13P/1tVVdbgcWWFhQu6NKxit2Za6vd5bbCQ6Zf1mi3+rP2
 Qsef+pjQkGkMahtFONC1mSBKZhmCEiR6tRreliVvLBmWlT/wXvOQ1AwYTjv7jOd+xRaN
 AOPHmw51qCzag2B1f+X6VT3yyxZeoaHqAUd6UyOBQDKYvrYPHW+aWHppy05gYprxXG7B
 VFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785771803; x=1786376603;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PsAGDFOalmANRUmQpq6erEVVHl2rEyxRaBSCENNWyfQ=;
 b=RAbQEq3xxpdmKoQJqoMdJnhuPHJNZGdG+PUM4NNKBjG2CBB/zBg2QAY+NNqaUf13YV
 CUF680hR1BKVlBcU/jqDcqP+qhS6HhqA8Ypf+YLMS4r/75vBv0oz/GTkGkS6SlQ0q9XM
 7/JAMr5E7QR5OfPi57+nYj6659OxadczLb2ZKlR2NXoEfsFKhzwNFpjRNFdaWx6x5lND
 YDUwVxi66MfyqArWkbmp53MyhAb4XrC8rn/XzGbEBb/SUYEIbPjcTu4yNa9pRwuCct51
 aiM163fuE0xD1fsUySvsPXy1rIE0OX0zBglypvqhX2kpxRzeWX1WnaAJO78VNZGCOJrv
 fcHA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro3LjEsBRe309e5m+sSEZ3SwD9Hq7ow+753UYNpUJcTuUspQof12QaNF9N1Fsg3ch8GeXJsDQ52tIJE@nongnu.org
X-Gm-Message-State: AOJu0YzsU0wA6AgsDJRxH/9kF1ZDryPYials6XHV6ZexQZD3N2feOXAV
 slEUQ8BUQsMhhoKd10fW2H9cbUdQQxtR1QNbC80x1F8ZOLHxylYtmzEm1e3u+Ic16+SJXFGV7iz
 vPaDKVCet/3iZXAbH5pOvYpOmCf6RdJTRYz6rWiDeVwLnppU5jAGofmxnDw==
X-Gm-Gg: AR+sD12vOmRIgtSij9I+U1XgReipZuvcjUfbKeSN32WQr3tWrKdk5h3/LLe2VqmSaOK
 4Dvk3AexuSEYOJZSS0CJSzGtG97C6P8A1DrlINnqLpICPtnadFJoqtyBvs4Dpji4qYHogf+Udgg
 bCBOKU76pXdOS8NI5JmXqBxRcAPwnwhdlAiDWI5Q8r4n47aTiSbW2C+5YPUSxK6UKbL9on+UtGy
 KFnh1kMUZ0n8l8qPDJPKeN0GYS+Rks3vwBa4WW/j6EX0xniAEzM4fmZzKQDYYZfRWhywcQVrUnf
 EyPKtqelTMm9R0NEadsGIchMP39wBnxWz05vzSU4vFeSQ2pHbhEgAR52UXUQxpcvexEUVS/iesL
 qNxuFvsXZIoGOzTeQqEsCcojWu+/A/AvHDH/9Nw3FCcD8FfCb9auvGRFyPVGyqA74
X-Received: by 2002:ad4:5d43:0:b0:8f2:860f:4dec with SMTP id
 6a1803df08f44-908496573d7mr198678056d6.15.1785771802993; 
 Mon, 03 Aug 2026 08:43:22 -0700 (PDT)
X-Received: by 2002:ad4:5d43:0:b0:8f2:860f:4dec with SMTP id
 6a1803df08f44-908496573d7mr198677116d6.15.1785771802308; 
 Mon, 03 Aug 2026 08:43:22 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-908435b607bsm77117096d6.23.2026.08.03.08.43.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2026 08:43:21 -0700 (PDT)
Message-ID: <6dfdd807-c6e7-4548-b4c0-73460295a7e7@oss.qualcomm.com>
Date: Mon, 3 Aug 2026 10:43:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 18/18] tests/functional/hexagon: enable more arch_tests
 cases
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 matheus.bernardino@oss.qualcomm.com
References: <20260730012824.1135905-1-brian.cain@oss.qualcomm.com>
 <20260730012824.1135905-19-brian.cain@oss.qualcomm.com>
 <0c791fd2-f4d0-4f3e-8ad5-4d61ccd724fe@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <0c791fd2-f4d0-4f3e-8ad5-4d61ccd724fe@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE0MCBTYWx0ZWRfX7e75LPdcJ8hc
 h5KoqnVbeMBpxVmUDM8kEJ6uOdFi5bPcs2YF9f8PZ6nzhp2X3pxstWtqiMh+BtFSa/ybdwO6bQd
 8WoJXISMk10tRhg+Gd9/RinKcby0uOg=
X-Authority-Analysis: v=2.4 cv=f/94wuyM c=1 sm=1 tr=0 ts=6a70b71c cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=iOqveM9gcD56OA4DGjMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: jwjlMKFrjjszHPr05qrvaeUS2Byr_ZfU
X-Proofpoint-ORIG-GUID: jwjlMKFrjjszHPr05qrvaeUS2Byr_ZfU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE0MCBTYWx0ZWRfX2bAv8fwrv+vP
 IkB8tf0V7zakY6sRzuVDj6b7Cho7zr3Eu2svGl7ZFV7lLNFTwiCbCopPLpqz/WYBa67Zr8sMp77
 zkNgoarsgqjMTdZwPapUcxpr4joyIKWTp4rk1+VN/1S6F1Mdc8xGqwU4fe3mhn9xtlKIzT1OYrf
 J+pGOogHmSk3chUdYehTHihDluKqw37jzWo40lmQt3f1kWE5NnuuAI+7DtjOzq2Fwe4w6pVKb3p
 TlEvxEuToA8o4SkIp0w6XsNX9jkWBb9S1HXc1PKVJVbvKSy1QcJf2q1v7yOLcpcPh0bwtdGS56+
 HpDvICoNyjsOttebn2lHm003mp/bWy0brDZn4JEDo/+MrlDvnnogWlawFQIR/P2Rn8gnP9xzZ/o
 kuxdismRftYx+TTwV5Q3vGFvu056dP4K4MZzZYlAwreFO8ESNyVU+n6F1IoPpJXOpcnC74/VNEM
 DdxZo7GL1CJVu/xfpJw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 bulkscore=0 impostorscore=0 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030140
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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


On 7/31/2026 12:42 PM, Pierrick Bouvier wrote:
> On 7/29/2026 6:28 PM, Brian Cain wrote:
>> Add more tests from hexagon-arch-tests, enabled by QTimer device.
>>
>> These exercise cache maintenance ops, l2vic, thread start/stop, tlb/mmu
>> operations, and user-mode transitions.
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   tests/functional/hexagon/test_arch_tests.py | 32 +++++++++++++++++++++
>>   1 file changed, 32 insertions(+)
>>
>> diff --git a/tests/functional/hexagon/test_arch_tests.py b/tests/functional/hexagon/test_arch_tests.py
>> index 2bb34f9b8dc..0834398c3b1 100755
>> --- a/tests/functional/hexagon/test_arch_tests.py
>> +++ b/tests/functional/hexagon/test_arch_tests.py
>> @@ -58,6 +58,38 @@ def test_int_steering(self) -> None:
>>           """
>>           self.run_uart_test("test_int_steering")
>>   
>> +    def test_cache(self) -> None:
>> +        """Tests cache operations: dckill/ickill, l2kill, dczeroa,
>> +        dccleaninva, cache disable/enable, barriers, and dcinva/dccleana.
>> +        """
>> +        self.run_uart_test("test_cache")
>> +
>> +    def test_l2vic(self) -> None:
>> +        """Tests the L2VIC interrupt controller: enable readback,
>> +        interrupt type readback, VID capture, and the fast interface.
>> +        """
>> +        self.run_uart_test("test_l2vic")
>> +
>> +    def test_threads(self) -> None:
>> +        """Tests hardware thread management: start/stop, MODECTL state,
>> +        per-thread HTID, shared memory, wait/resume, STID priority, and
>> +        SCHEDCFG/BESTWAIT readback.
>> +        """
>> +        self.run_uart_test("test_threads")
>> +
>> +    def test_tlb_mmu(self) -> None:
>> +        """Tests TLB/MMU operations: write/read/probe/invalidate,
>> +        global entries, multiple entries, overwrite, ASID matching,
>> +        and permission checks.
>> +        """
>> +        self.run_uart_test("test_tlb_mmu")
>> +
>> +    def test_user_mode(self) -> None:
>> +        """Tests user mode / privilege transitions: supervisor mode,
>> +        SSR UM/IE/XE/CE/PE bits, and the trap0 user-mode exit handler.
>> +        """
>> +        self.run_uart_test("test_user_mode")
>> +
>>   
>>   if __name__ == "__main__":
>>       QemuSystemTest.main()
> A general question on the pattern we have here.
>
> If those tests can be compiled with hexagon-cross container, would it
> make sense to add them to tcg/tests/hexagon/system directly in the future?
> Hopefully will be more easy once we have meson tcg-tests, so you don't
> need to add all dependencies by hand.


Glad you asked -- in a downstream fork, we originally did have several 
tests like these (not these particular ones but ~similar scope) running 
in check-tcg.  But we pivoted away from that because:

1. they're not testing merely translation: they depend on several sysemu 
devices.  More like integration/functional testing.

2. sometimes it's useful to verify not merely the exit code but also 
some output text to semihost/uart console.  This *can* be done with 
shell programs in make/meson, but it feels like "coloring outside of the 
lines."

3. most other architectures seem to have fairly ~light system emu 
check-tcg tests, perhaps because of #1/2?


We did this change with the assumption that these sysemu check-tcg tests 
wouldn't be welcomed by community because it diverges from what other 
targets do.  But maybe that was an overreaction?

It's certainly convenient to have test cases in-project so that changes 
to the tests don't require an indirect step to update a test code repo.  
So, we can do whatever best conforms to the project idioms in this 
regard.  Note that these particular tests in this patch are written in 
Rust and would introduce a new dependency (in the existing container, I 
suppose) beyond the C/C++ toolchain.  Fine w/me but food for thought.


>
> Regards,
> Pierrick

