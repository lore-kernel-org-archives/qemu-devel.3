Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F35606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RPpCbPn5;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LDaxH9rF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMntm-0007dl-4F; Fri, 30 Oct 2026 10:48:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMntV-0007bd-8M
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:47:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMntT-0005jn-Hv
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:47:49 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERC3I3564399
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 14:47:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qrfuyehRE32YVocCF0kS6lwkd9c/5VZpwAKaIN6RFQE=; b=RPpCbPn56GvxDrJI
 PmNdS0YS8R0LfgAWtzzqPnJ17L0jPK5eJpwFTCftp1i82siTmbZjjfA03EFQfjJu
 6nuTEmsV4P0e1U0I09lYsNt5o6ZP8XT/bBUyr/n9z8MyVhzEHUy141A8ywwdEI+a
 J220sy05Q6/vPTVTnK0L7UkMbCeJTWsvktGW1aApJ12u6S94dho88azxDHx62oMu
 EAAWnJ2qbNaFfmElRy8y9yjuZSUjILi779rkLhkMLNa/uz867Lnn8PytD+osLcdj
 4yGr6tU6sLRIxWqowTlM7sUavns9P5ue8eBOs18IT9xnoaOYNXv592gRKZAGgwcK
 NT5kfQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qkhu3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 14:47:46 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f559420f3so70353585a.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 07:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793371666; x=1793976466; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qrfuyehRE32YVocCF0kS6lwkd9c/5VZpwAKaIN6RFQE=;
 b=LDaxH9rF1jfk81JWYx6C2Me5OipLgjxMtVieWghfbtFFjcgVNYeJqAguio2prfEgSR
 iV/cvmsId32R9zDi7V7lzD3S9KR3D1vQNXYUf/pI2cJIQEwl3NQwvINERKUpYT6Be4CH
 bQMnZQDUHW6/XKeAOY/6JyhUsXBS1Yiaz/415YtAnMorySdFiuqhILeZuSA/uZjs5WOg
 q7sO2/IANznw1WVOGI5w6ofl9YSlFVG0fQ5LSGltRVtVvNMPnUcxtLYDTuyZ0lHOh6/C
 aR6TNiKPd4N3KjoiBZ1WLIbAOLIfrPoFUrMjZ87SBnnfXe6PliQZ2wcYXAmQM8GMcZ9M
 ZQxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793371666; x=1793976466;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qrfuyehRE32YVocCF0kS6lwkd9c/5VZpwAKaIN6RFQE=;
 b=L/Eaqxk1iYS1MzoeD0x1fST5mAFiE+AU4pnyKdtLyb5vc9ltGuTrXnouSQ6D/0sE3B
 PhoGXXf2m9ztEd8yJ6S30kuxNveZo9CCV3rMlfgzogrqgzt01m0NXuu+hkl69w3bD0WA
 G+6E4fPooM5o0lSmH6CkHdUXG5AXNtbhTHotl7J73WVv1oS+b6sn585VFbgWpd1oTzkq
 XRM2aFuBG7C33mnAf//mG1wW+xrxn8WzzhVf8jybuvDSGBUg7FISFi92KM8OuIzPIKwU
 zBV6K6Trs5Ai23f9NIU6qY7XdTE2rp2B9hnDVheoeMBEbmy1q5jPaBFEeHG27UAGvpm7
 7a7w==
X-Forwarded-Encrypted: i=1;
 AKwUvBw1+zpmQPClRCDiYWFP/JjtKej8NoH9XzRsnSB7wu9D2XchU+LnXzrbdBxNE5RCklkMBVJtNxBMG2jH@nongnu.org
X-Gm-Message-State: AFq9FYI8Sc7r7BXiiYYMoG6PPN4GTKBTa9Vz/OT9yQBzW1GppjVIg/+A
 KfwP3BkdsS7hqOW8/HDhIGkpAPfUJgilvSdaheZ5hw3Dot16FmEoRZWReJvXNQ8vV6LmoOagFja
 PE/FVrclfPL++v8ZCNmEQdIzXKmj+7iSrQH0qdO6eR3IhofegT7MLfTDK+A==
X-Gm-Gg: AYBFou20dmdBUmfk8w8vRjsds/hrUN+0WuTcy28AvOFKGPXENnW76Uu8bOHBlDvvh7J
 w/kN7l5QEH8hLvxO53SN0Z9cmE515W9Jb45nICOmTQGbeYmn+4KDA/r9BrFgNbNXtFzZ5iJpkxv
 femsuA/51KY3xMCmcFmFalyXsSYNQpUv8xYe3MWQIsBHV2liUE3xWr6WCrCXvjm/k7xpBUycf9n
 YA0+PWnuetbOFzVbs4NYIHIrEtjZUWpb1ovRVsdDZBPJJmzjxx9WBrbpT0+64JntuZqcp4Nl3MB
 7sypeR9gWvKbKI5MxrQUe2P9ARbDIJD3P8QDCjJxIFqsc8wabgVWIAbXUMaflldS7y2SQ81Gyu0
 YULaAOi3bKzOP44tujgAAeMSmQf3jrJizRI6425wQin6XtjSD3lzlSWNG9aazTuSxmO0LTGNAj+
 laJvlXRc32gaERD/PJWYjUVVC1DEMqIOm3t7DR+Q==
X-Received: by 2002:a05:620a:801c:b0:93e:c12c:fbcd with SMTP id
 af79cd13be357-944217a3ad0mr415300785a.73.1793371665483; 
 Fri, 30 Oct 2026 07:47:45 -0700 (PDT)
X-Received: by 2002:a05:620a:801c:b0:93e:c12c:fbcd with SMTP id
 af79cd13be357-944217a3ad0mr415292585a.73.1793371664753; 
 Fri, 30 Oct 2026 07:47:44 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4cab9dc577sm73675466b.0.2026.10.30.07.47.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 07:47:43 -0700 (PDT)
Message-ID: <61c88417-a8ff-4ec2-bde7-03636d10bf2b@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 09:47:40 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/20] tests/functional/hexagon: add HLX system-mode tests
To: Marco Liebel <marco.liebel@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
 <20261029174413.643130-21-marco.liebel@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261029174413.643130-21-marco.liebel@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: n8kitfwdHJzNVK2W4JFCF7w0NGTvXKLj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1OCBTYWx0ZWRfX5JILkU3js5yd
 tpp7MUuiagD73yBpfxqztK7xXEhJ46eWeN/3+SERmge8ukQ0WcLxWt2FAjpJgmj5SwgqJQalbvO
 iWCXxBqsT2PuW+3SvYGPdkFwxsyWdzI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1OCBTYWx0ZWRfX5r0kCOPn5qQ0
 I0759yB+ncuMWvGCNj9blXEuLXt+Un9QL08Wpyu6gv+Aq02KQC8y1l7n2xCOuhplxww7AKGkb/C
 EewhQz8IeL914tDR4FSQJHNzgk08PgpHCEfqRxPw6OyzyYCTYMlH+pcqrLHUwdb/iLBtJY4FmEG
 gXzufW0N53AFMRieHWN7yzY+JJwkmbJncvV8GZv41loj+gMK7StAlzSrMeiGbB/fA9q3ZjXp7Kj
 68bkUfutMQQVsDmilR6nAs4xMzKN3ZYiaHDEdZNuMWtMMk2S58o/RezKy2ugEqKEomX3dg7N7uM
 2jPWLZKqAw2Q1Yw+CBNwkuzjBs31oOxSPWJwXnQ89XWghEqmTqErpursL5aKlMi0YBhUTE/tW65
 DXqijvLcKUFZuN+RcoWMgCG58A30fX+pW75fnPzV71xNDwSKctniR4vn7bNRcZ47rx3RobBKqF0
 F5SapLzNLacd9Kz/LXA==
X-Proofpoint-ORIG-GUID: n8kitfwdHJzNVK2W4JFCF7w0NGTvXKLj
X-Authority-Analysis: v=2.4 cv=TpVzFzXh c=1 sm=1 tr=0 ts=6ae4ae12 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=5vFef2XoAAAA:20 a=EUspDBNiAAAA:8 a=_34csh4cu3W2huHqD9sA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300058
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/29/2026 12:44 PM, Marco Liebel wrote:
> Run standalone HLX tests on V85QA_1 using a prebuilt, hash-checked
> archive. This avoids requiring the standalone SDK in QEMU's test
> build environment.
>
> Cover CCR enable control, enabled execution, values across packets,
> VSP accesses and VTCM loads and stores.
>
> Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
> ---
>   tests/functional/hexagon/meson.build |  2 ++
>   tests/functional/hexagon/test_hlx.py | 49 ++++++++++++++++++++++++++++
>   2 files changed, 51 insertions(+)
>   create mode 100755 tests/functional/hexagon/test_hlx.py


Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>

>
> diff --git a/tests/functional/hexagon/meson.build b/tests/functional/hexagon/meson.build
> index 0fd90e491a..cf87ea3211 100644
> --- a/tests/functional/hexagon/meson.build
> +++ b/tests/functional/hexagon/meson.build
> @@ -4,10 +4,12 @@ tests_hexagon_system_thorough = [
>     'arch_tests',
>     'qcom_dsp_firmware',
>     'systests',
> +  'hlx',
>     'minivm',
>   ]
>   
>   test_hexagon_timeouts = {
>     'qcom_dsp_firmware': 240,
>     'systests': 180,
> +  'hlx': 180,
>   }
> diff --git a/tests/functional/hexagon/test_hlx.py b/tests/functional/hexagon/test_hlx.py
> new file mode 100755
> index 0000000000..6adf2f8d49
> --- /dev/null
> +++ b/tests/functional/hexagon/test_hlx.py
> @@ -0,0 +1,49 @@
> +#!/usr/bin/env python3
> +#
> +# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +from pathlib import Path
> +
> +from qemu_test import Asset, QemuSystemTest
> +
> +
> +class HLXSystemTests(QemuSystemTest):
> +    timeout = 180
> +
> +    ASSET_TARBALL = Asset(
> +        "https://github.com/qualcomm/qemu-hexagon-testing/releases/"
> +        "download/v0.3.2/hlx_systests.tar.gz",
> +        "8b4340749d48fe33c23726907ac7d533f801e38f0842fb5f46346aa7b3eaa5a7",
> +    )
> +
> +    def run_hlx_test(self, name):
> +        self.archive_extract(self.ASSET_TARBALL)
> +        kernel = self.scratch_file("bin", name)
> +        self.assertTrue(Path(kernel).is_file(), kernel)
> +        self.set_machine("V85QA_1")
> +        self.set_vm_arg("-display", "none")
> +        self.set_vm_arg("-kernel", kernel)
> +        self.vm.launch()
> +        self.vm.wait(timeout=30)
> +        self.assertEqual(self.vm.exitcode(), 0, self.vm.get_log())
> +        self.assertIn("PASS", self.vm.get_log())
> +
> +    def test_ccr(self):
> +        self.run_hlx_test("hlx_sys_ccr")
> +
> +    def test_enable(self):
> +        self.run_hlx_test("hlx_sys_enable")
> +
> +    def test_packet_values(self):
> +        self.run_hlx_test("hlx_sys_persist")
> +
> +    def test_vsp(self):
> +        self.run_hlx_test("hlx_sys_vsp")
> +
> +    def test_vtcm(self):
> +        self.run_hlx_test("hlx_sys_vtcm")
> +
> +
> +if __name__ == "__main__":
> +    QemuSystemTest.main()

