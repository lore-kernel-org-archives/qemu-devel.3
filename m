Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D661EC5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 04:48:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvpGa-00025W-AX; Mon, 17 Aug 2026 00:48:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvpGY-00025J-9A
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 00:48:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvpGW-0005Cm-8q
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 00:48:06 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GLD3a4663884
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 04:47:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HizkOWB0vzAFZeAmZvECllV8kQcuowP/1KY9uktwa0g=; b=QWfvybuXOmzgEbq0
 MvWpetcEgBeoGJbXwvo62D29BDRKANEZLcWWxfoNJu6D6Y5eMszOI/V8zBw2U4Hf
 KBgS0OpZ8mw5IuuwlY8Sv6mOFPARHfIiD8Q5CfLW1C4EuHUdbe9tDJjWJDia0JUK
 coTziT8VLCPQgIjJl26LGPnczNSO6VFKT2W7bflt2FWnpvKNy6SlAJ7QrqaKRh05
 i+41J/oG/ZpLpnEnP/ht/gNT82zOwtjjUXaRzl8eWHiMpyc95/RnMpbeWv9iebk+
 HCwKNTsJlI/o/xrz3yl1qUhu97oJu/VfC3pC205FhNwmkhhJgFxq1/GZtl6QrRSO
 tCsVzQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghnw6f8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 04:47:57 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e53b8a302so311888785a.1
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 21:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786942077; x=1787546877; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HizkOWB0vzAFZeAmZvECllV8kQcuowP/1KY9uktwa0g=;
 b=bMxWbIMQTKNsdk9DoBAQHGd2piHKfK6BMhIo4KwAVpuWnBC/6xr+sbtiJZTvB3bx9g
 HpHIHByf76CwLZoRXtrWiyuwtiILXuKUzgUaZv6EGMOBhiw4zU/dF2s6wsUbtQ1iQQEh
 ff6XMsCKsCjL6k5ZZQ4eoXWq4uMP6rE3BCTlRar35sNyPGcR7b1/i0CKGlINftoE6jtJ
 fJH9HadmU9NF442i+osLGx2N5aro4FTlCWNJwx6qetznwZa43y5dgexNIE/kWKxMwJR/
 i96sr3mkniXhoATzK8ryIaZhtZoPxKX7oIpXeAJ02XRon/cusCnsb0jdEP9jsKACPRjG
 Jsfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786942077; x=1787546877;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HizkOWB0vzAFZeAmZvECllV8kQcuowP/1KY9uktwa0g=;
 b=DE8pAa1JBdBiw4A0MnLJ0YlS7lC0y2WzQDU7h1rOF23mejOt4J108Awi6H1D2zl1My
 lM2jRt3ZWRtAL9pqcAWHSpszzISUwkCC1iRELwzC0SiiCzfs8vgXxoKfwdhF4mwW0jkI
 /iS8XuL8QoaaLWmMsQQerNy9G+k02LItuw6/XK/WsoSAtz5/xveH1+jeq89QzW1RaUIX
 K8r6aZlVh0L0asJ1kfd3Im776mnpLvQJ7Yi6uauYCKoGP5VnyiwVBdeiJgtstelinYgH
 4eE/dmyz1JPp20Y/hUCrH3cBlaFz563+kt5qWWRUYorVTmAuQfIzgpme7UPaMk67jkm2
 RJWg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqLDmPP1L8yUIaVt2jXKeYsxK6AFgWwx8wj5987iPenDsP6fQ+oHHEWW/Us/p/i7Zj8QLMh7o9hFMX9@nongnu.org
X-Gm-Message-State: AOJu0YytpHYPKGYndmLogl4hXA4jHCnzz28mc1NUvJCUC3AnydZoTNy0
 aQh1shcHDeqMLjorPZJz1zoHlQmcD3GoSrRicLyoZ+z8v60ga2sv43qM3/4Uc8qbDqgNlB3RwNc
 mdlg40mIoHsDAcRhlcUbXS6kzBo5vy8zFjvDoA41qxbyFEhOzFX+UxD0ZEA==
X-Gm-Gg: AR+sD13YSpGOUGvFnrAYJHmUyew5AZGAF7msn2BPDeh7DShtC6z76bqr7W3PAvO/46l
 50vmeLd6KuW+HjxHzDJHGUscQDwNxJEUMc3vp2tsa4FPVst/BVGC8XjEyEpPeLLGe8PIQjm8UkF
 e98o6H48yT+boB16hITwhDYVy0EUtbKz4AE/kdrbqB5RlESCbApGCG00k3AUteFozWbDLQ+CiLp
 CswRa+xwhKC0uyPnXtyFGKddNKuLmjR8egkfSsTR+S+wXpbrZt2tcMKSvMPf36FaaHp3ud3qbji
 5Wy7Rs7fJ4/eZQSH8wZk9d0weIxw5tBY+GX7DpGuDEzIgg1L5dikg233Vs9P84D+E7xx0rImfmp
 wPETbeXmDZO2gz4DSvlv8A1yAvqyuJMs7Je0=
X-Received: by 2002:ae9:e51a:0:b0:92e:e3eb:de54 with SMTP id
 af79cd13be357-936d201e8c4mr2059560885a.11.1786942077316; 
 Sun, 16 Aug 2026 21:47:57 -0700 (PDT)
X-Received: by 2002:ae9:e51a:0:b0:92e:e3eb:de54 with SMTP id
 af79cd13be357-936d201e8c4mr2059559085a.11.1786942076813; 
 Sun, 16 Aug 2026 21:47:56 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996100184sm147463715e9.1.2026.08.16.21.47.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Aug 2026 21:47:56 -0700 (PDT)
Message-ID: <815d60b5-3bc1-4c4d-baaa-90df17a75f58@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 06:47:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/13] tests/functional: Add hexagon semihosting
 systests
Content-Language: en-US
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng
References: <cover.1784568922.git.matheus.bernardino@oss.qualcomm.com>
 <4299b53256dfab6d43bc9c591797b50710b8af6e.1784568922.git.matheus.bernardino@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <4299b53256dfab6d43bc9c591797b50710b8af6e.1784568922.git.matheus.bernardino@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDAzMyBTYWx0ZWRfX7q9tG+/1EZ1i
 wnjeFOXVPVxdfc3GBmD2atZ4Qr0WGYzUDG+H3/cbLj0dQXhGwSd7jOZThECntHK86+3lxUvll9i
 uq2dxUH93+ki9bJ6sS9Xh+RIWb7gDwYBfkLE8jexz1flt0Cx1EhiJnAM9gJ89mji/XK8HSVkd4z
 2EY1pAkQdfjrPQ68Xxyf4R/busI8E6vUiy8uwIb/ov38flv37a5zIUxasb1CBeOT8V707Ne8GK1
 lEIzHMO3PSOVjQ2ZNNncM1g4He+6pb0m+Z8F9VpBub/eZBVheofoMgJeTiD75rS3oRctl0HgoSW
 R/QISKN6xB38UCL6Rs5y2pSz/+zzG3WFILQlJXdQVBSBHevC3lxR1b4g8u26XgAkmQ/6fWslZLY
 tRyd+6K8zGt3Z4GbfXa15qvg71GdYpprXH7R/PcCobID+uceFzia3KtxRxHOyVXbLOmw7OZL1u+
 zc4YCZBo6S+DH/F0fsg==
X-Proofpoint-ORIG-GUID: azKU6CQrwbY-Pp-MLRdcqgoztwZuknxn
X-Authority-Analysis: v=2.4 cv=QN5YgALL c=1 sm=1 tr=0 ts=6a82927e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=5vFef2XoAAAA:20 a=EUspDBNiAAAA:8 a=xlUBKCCO76h7Xdkf_WwA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDAzMyBTYWx0ZWRfX4RDJZeKDsiWr
 rfb1jeTy2t8KnkHsvuiCNm/unRCDuDLPpYhHG2bz5XEJt4cGCzYMUZpcoTnVX2KkLdzcw9Q0P/A
 MTIKYKkaje6oUOBcgPTM8HIQYTQ9bBs=
X-Proofpoint-GUID: azKU6CQrwbY-Pp-MLRdcqgoztwZuknxn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170033
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

Hi Matheus,

On 20/7/26 19:41, Matheus Tavares Bernardino wrote:
> From: Brian Cain <brian.cain@oss.qualcomm.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> ---
>   tests/functional/hexagon/meson.build      |   5 +
>   tests/functional/hexagon/test_systests.py | 110 ++++++++++++++++++++++
>   2 files changed, 115 insertions(+)
>   create mode 100755 tests/functional/hexagon/test_systests.py


> +class SysTestsStandaloneTests(QemuSystemTest):
> +    SYSTEST_TIMEOUT_SEC = 30
> +
> +    ASSET_TARBALL = Asset(
> +        "https://github.com/qualcomm/qemu-hexagon-testing/releases/download/v0.2.11/systests_standalone.tar.gz",
> +        "b5777aa65245de7710a7a08d717953c1362be7c8b60d9014c9fee8b17610ad1c",
> +    )
> +
> +    def setUp(self):
> +        super().setUp()
> +        self.archive_extract(self.ASSET_TARBALL)
> +
> +    def binary(self, name):
> +        """Return the full path to binary *name* inside bin dir."""

Hmm this is scratch_file() contract, not sure if worth documenting.

> +        path = self.scratch_file(*_TARBALL_BIN_PATH, name)
> +        self.assertTrue(os.path.exists(path))
> +        return path
> +
> +    def run_exit_zero(self, binary_name, *extra_args, machine="V66G_1024"):
> +        """Launch *binary_name* and assert it exits with code 0.
> +
> +        :param binary_name: name of the binary inside bin dir.
> +        :param extra_args: optional pairs of (flag, value) strings passed
> +            to set_vm_arg(), e.g. ('-append', 'myarg').

Why document that in a test?
> +        :param machine: QEMU machine type (default "V66G_1024").
> +        """
> +        self.set_machine(machine)
> +        self.set_vm_arg("-display", "none")
> +        self.set_vm_arg("-kernel", self.binary(binary_name))
> +        for flag, value in zip(extra_args[::2], extra_args[1::2]):
> +            self.set_vm_arg(flag, value)
> +        self.vm.launch()
> +        self.vm.wait(timeout=60.0)
> +        self.assertEqual(self.vm.exitcode(), 0,
> +                         f"Test {binary_name} exited with "
> +                         f"code {self.vm.exitcode()}, expected 0")
> +
> +    def run_console_pattern(self, binary_name, pattern, *extra_args,
> +                            machine="V66G_1024"):
> +        """Launch *binary_name* and wait for *pattern* on the semihosting console.
> +
> +        :param binary_name: name of the binary inside bin dir.
> +        :param pattern: string pattern to wait for via wait_for_console_pattern.
> +        :param extra_args: optional pairs of (flag, value) strings passed
> +            to set_vm_arg(), e.g. ('-append', 'myarg').

Sorry, this is not useful, just noise making the review more painful.

> +        :param machine: QEMU machine type (default "V66G_1024").
> +        """
> +        self.set_machine(machine)
> +        self.set_vm_arg("-display", "none")
> +        self.set_vm_arg("-kernel", self.binary(binary_name))
> +        for flag, value in zip(extra_args[::2], extra_args[1::2]):
> +            self.set_vm_arg(flag, value)
> +        self.vm.set_console(semihosting=True)
> +        self.vm.launch()
> +        try:
> +            wait_for_console_pattern(self, pattern)
> +        finally:
> +            self.vm.kill()
> +
> +    def test_fopen(self):
> +        """fopen reads a file passed via --append and verifies its contents."""
> +        import tempfile
> +        # The fopen binary has a short cmdline buffer; use a short path.
> +        dummy = os.path.join(tempfile.gettempdir(), "qemu_fopen_test.so")
> +        with open(dummy, "w") as f:
> +            f.write("valid\n")
> +        self.run_exit_zero("fopen", "-append", dummy)
> +
> +    def test_ftrunc(self):
> +        """ftrunc truncates _testfile_ftrunc from 6 bytes to 1 byte."""
> +        ftrunc_path = self.scratch_file("_testfile_ftrunc")
> +        with open(ftrunc_path, "w") as f:
> +            f.write("valid\n")
> +        # Sleep 1 s so mtime change is observable
> +        time.sleep(1)
> +        self.run_exit_zero("ftrunc", "-append", ftrunc_path)
> +        self.assertEqual(os.path.getsize(ftrunc_path), 1,
> +                         "_testfile_ftrunc should be 1 byte after ftrunc")
> +
> +    def test_access(self):
> +        """access checks R_OK|W_OK on _testfile_access."""
> +        testfile = self.scratch_file("_testfile_access")
> +        with open(testfile, "w") as f:
> +            f.write("valid\n")
> +        self.run_exit_zero("access", "-append", testfile)
> +
> +    def test_semihost(self):
> +        self.run_console_pattern("semihost", "PASS", "-append", "arg1", "arg2")
> +
> +if __name__ == "__main__":
> +    QemuSystemTest.main()

Did you run this test on a big-endian host? I'm suspicious about some
guest to host conversions.

