Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C021FC531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 16:46:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnJ1s-0003cV-Sf; Fri, 24 Jul 2026 12:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wnJ1r-0003c6-5E
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 12:45:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wnJ1o-0006Dj-UX
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 12:45:42 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66ODbZVY3090677
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 16:45:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Er9UYAn43nIvyipemIGAIRDrNGe1X2GkurCZ3sGKTNg=; b=HGe7xiFmajkpY4sY
 aImzv41cUHaupTp+6RH1cG5iixXEXE29XrdlK8G4GJp0funHA2yJ4F2Ge0DA8wAr
 jeeGcrzqvk2tyzeU+dcNJ7lI5ZOETygeWqHvusgxRaWAZyg7EwrBFnewiB25eEYN
 I3jtaXMdZoqwf2y5PtOQ+I7RBDcL/h9U6kH+Y19xNSCrCrqGNHTN+T6v1GlhnsSs
 puIANUx4hXbFlRnnsPq1jji74z1IyMXsCiriLPVmoNWnwuNOBfPnASwiERXEr4LK
 nvEViicV/ewlLG+Yxm5gXC1n11Fm2KRkl0b76g+mXMcMLVwnYVjt3PUliKCtV6mZ
 j+ivJw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm8cggv8n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 16:45:38 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cb711c88f2eso384210a12.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 09:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784911538; x=1785516338; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Er9UYAn43nIvyipemIGAIRDrNGe1X2GkurCZ3sGKTNg=;
 b=MNzQhOJSWNZBVcni5kZxfzjoII+RU0ZtyqY75TDVuT8NjCq/b+q/SYAasZEsnLtVuH
 sJRazekz/OuckgHzCbaQuzfzOnvGBQaDs+fCrOZvQOOB9JayxcxSYIHWxM68kOFRYlvf
 +yOFpxG35A88EzwOifcrA2yf3NWWhVlAADvs+bdo9F7R98w9r/c3KbCrMupbp7OZu7tX
 LErcIv7y6niOBjzxbfifldXyQPWss83tjffUnTmuF5HNsVdOq733lDIVy2P6AtAQlTB/
 GpykuILrjEgQUfoSbsatw6ORzEerltmRFNDC/0bDKnAs97PxTRsN8/H/TQwEJm/LMk0P
 IVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784911538; x=1785516338;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Er9UYAn43nIvyipemIGAIRDrNGe1X2GkurCZ3sGKTNg=;
 b=aXG3r7/Nc+gVhCpGNLJLrCtQ+TfJUe9c6rbV2C2SI0GGQJO7iLFwpYxivJf2S9Wfjz
 Pi7a4opEUIaNEx/lGUXR2dVYP500/qQoWBlf/LwVkZI7TSCy51OMlIdYRQ+hg1yKKIlC
 bPA2TmmljS8cuJOdT1ODxT3lHD801Y9mK0XHLOv6dGkyaSaFb1O9nnDEJeGcNYfLLSyk
 /XzZGGuIWhGP3gnL901A3GjehfEn28eFp6XHUtDo0ZB3CalChMP3LokFaWVjhXwpnJGx
 IStHzemoksfYDi0UzQaX0PiKrme5bw5g/OlMLGNjnddhaj+94nwKTB25zyk7+KfYt7BC
 dFnw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp3tgof+YJaIy/gdYniUa15Le2AtQRbztnGs0zfVGbIlc6C9in8g4LIaH4Iu6q/W0ZZQs2JWfO+DGSw@nongnu.org
X-Gm-Message-State: AOJu0Yy5nddIXcIQHdniCLuGHnFNNx4NrrODrxax3xfvy3GqoUtwXYAb
 djAVanupvz++NO/N9eJ3fb5BqFhwCV9XZpEPvSJuwzLGdL0YxAZCUrqaoji6bXYQNZYNPYykLJY
 RuCDoOAEcOU5egMrZVJ+OeIJCdV4nVPPY21FUuvXjN/mJXVUQUF8fTBVApg==
X-Gm-Gg: AR+sD12YTUTDN2CigBDLwCWcJYtD4eWNDIQHP0MpZWYF3ls1HNFtNzkhTsngwpbyI9z
 xiOXO6xemPnOfc9vyqa8FtrCEoRcEn+aFVUnAvKW0FGAmRU1uNdFwSCPtnPaVwFK6eWvEreVI2C
 /FvU0uZPQFFM2wqzX/4gaonmkyA9sZ3DwFmfOz6Or88PxBWQZIoyXQEAgdTZBBxCDLsFi6QfwGi
 aCyLeG8K0MPjK/tRbcePgaU5EoJOuq7SSGeComn6NRjorUbgZmzWyKik0ajGtpCs8EM8RQmc/6L
 elLGmGApYV5Z+tE9wpG7vgexbd/TTPO+OYVATxzTbnKiscfQvcSmOiKvXUyP5ZWOyaZJNzYs5RS
 EL0+gNvNiepUWkaF98EM5EnT1H4RbMHsenCSYKa3OOI5GAOnVEPj0rKy8CyhP1UFVwxqD
X-Received: by 2002:a05:6a21:6f07:b0:3c4:3321:4fe9 with SMTP id
 adf61e73a8af0-3c44afd2b84mr9342027637.7.1784911537526; 
 Fri, 24 Jul 2026 09:45:37 -0700 (PDT)
X-Received: by 2002:a05:6a21:6f07:b0:3c4:3321:4fe9 with SMTP id
 adf61e73a8af0-3c44afd2b84mr9341992637.7.1784911536939; 
 Fri, 24 Jul 2026 09:45:36 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc288a79sm1081297eec.0.2026.07.24.09.45.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2026 09:45:36 -0700 (PDT)
Message-ID: <708798a8-3d43-48d9-a4f6-210eb88a88cb@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 09:45:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add option to disable building tests
To: Florian Schmidt <flosch@nutanix.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20260724135413.1716872-1-flosch@nutanix.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260724135413.1716872-1-flosch@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDE1MCBTYWx0ZWRfX4olG4nzUuZeX
 xi3aDAIIMfiZN3FWHtsPi6yjve16py0/sQdz1PAwy21zM2QOnBwY4RIhJxkaL0GtM+JEX3d46Mk
 GmVPBtEHpv3Qfl77FBcho3DuWtAX6UMaM1jJlcPGTS924P4arml66bjeAY2xctKqr2UL0turRWd
 1VUR1bYuNTiw80qBMrdtxushbj4Ma3AzT9DjIERV6RCjOYs7ddK5yIJDwBI4GSJy9P+vVsCtkzE
 5pS/2PQU2YJ3DykiLFp0CVcY7ard7Xg8+j9iYJEkBGcmyzUzmPdybip4doiHGGvQ8IDLbU78vX0
 K7tR8JrGn/jmr72WQM9CXUSYxv+R2NGs/pXM9WXTLPgAyToqEMSz5u7RPaUGgCxvM0LmUzHFDih
 WPPWpeqatlCGiziqd4j1xWza57+dwmw/B1qbEKVPWkA+8PTDiBbYFBcg3pf0k1bwlirEdso/WCr
 WhQpjLErinx1lFukEMA==
X-Proofpoint-GUID: Pf00LC7q6ypC2qjJu6RNUzFTso89uJop
X-Proofpoint-ORIG-GUID: Pf00LC7q6ypC2qjJu6RNUzFTso89uJop
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDE1MCBTYWx0ZWRfX9r99fPIWqMi5
 ejs5uY4/r/9oI+IcxCNM3LbaYWhUxIXQSve0mbDcmspHs4hvYboOYjPNzR2C1wEqwMqT6ZrSXsr
 SUVe6ZpCKH3z2YRM1fYGfVAf5Cx1Ias=
X-Authority-Analysis: v=2.4 cv=P9sKQCAu c=1 sm=1 tr=0 ts=6a6396b2 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=64Cc0HZtAAAA:8 a=EUspDBNiAAAA:8 a=B7KNsiDRLG0zOIzK5J8A:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240150
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

On 7/24/2026 6:54 AM, Florian Schmidt wrote:
> There are situations in which you might want to build QEMU without
> building the full test suite, which in some configurations can take a
> considerable amount of time to build. This is especially true when using
> LTO with clang. For example:
> 
> $ ../configure --cc=clang '--extra-ldflags=-flto=thin -ffat-lto-objects' '--extra-cflags=-flto=thin -ffat-lto-objects' --target-list=x86_64-softmmu
> [...]
> $ time make -j8
> [...]
> [3078/3078] Linking target tests/qtest/qos-test
> real    6m43.250s
> user    101m15.967s
> sys     4m3.813s
> 
> $ ../configure --cc=clang '--extra-ldflags=-flto=thin -ffat-lto-objects' '--extra-cflags=-flto=thin -ffat-lto-objects' --target-list=x86_64-softmmu --disable-tests
> [...]
> $ time make -j8
> [...]
> [2024/2024] Linking target qemu-system-x86_64
> 
> real    3m14.277s
> user    33m13.174s
> sys     1m36.642s
> 
> Add a toggle to optionally disable building tests.
> 
> Signed-off-by: Florian Schmidt <flosch@nutanix.com>
> ---
>  meson.build                   | 2 +-
>  meson_options.txt             | 2 ++
>  scripts/meson-buildoptions.sh | 3 +++
>  3 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/meson.build b/meson.build
> index 49a5baf5b5..ad728c26ec 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -4605,7 +4605,7 @@ subdir('docs')
>  subdir('pyvenv')
>  # Tests are disabled on emscripten because they rely on host features that aren't
>  # supported by emscripten (e.g. fork and unix socket).
> -if host_os != 'emscripten'
> +if get_option('tests').allowed() and host_os != 'emscripten'
>    subdir('tests')
>  endif
>  if gtk.found()
> diff --git a/meson_options.txt b/meson_options.txt
> index a07cb47d35..68333ca402 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -43,6 +43,8 @@ option('gdb', type: 'string', value: '',
>  # on the configure script command line.  After adding an option
>  # here make sure to run "make update-buildoptions".
>  
> +option('tests', type: 'feature', value: 'auto',
> +       description: 'Build the test suite')
>  option('docs', type : 'feature', value : 'auto',
>         description: 'Documentations build support')
>  option('fuzzing', type : 'boolean', value: false,
> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
> index c003985047..3fec13a336 100644
> --- a/scripts/meson-buildoptions.sh
> +++ b/scripts/meson-buildoptions.sh
> @@ -194,6 +194,7 @@ meson_options_help() {
>    printf "%s\n" '  spice-protocol  Spice protocol support'
>    printf "%s\n" '  stack-protector compiler-provided stack protection'
>    printf "%s\n" '  tcg             TCG support'
> +  printf "%s\n" '  tests           build test suite'
>    printf "%s\n" '  tools           build support utilities that come with QEMU'
>    printf "%s\n" '  tpm             TPM support'
>    printf "%s\n" '  u2f             U2F emulation support'
> @@ -515,6 +516,8 @@ _meson_option_parse() {
>      --enable-tcg-interpreter) printf "%s" -Dtcg_interpreter=true ;;
>      --disable-tcg-interpreter) printf "%s" -Dtcg_interpreter=false ;;
>      --tls-priority=*) quote_sh "-Dtls_priority=$2" ;;
> +    --enable-tests) printf "%s" -Dtests=enabled ;;
> +    --disable-tests) printf "%s" -Dtests=disabled ;;
>      --enable-tools) printf "%s" -Dtools=enabled ;;
>      --disable-tools) printf "%s" -Dtools=disabled ;;
>      --enable-tpm) printf "%s" -Dtpm=enabled ;;

That's a great addition, including just for speeding up normal builds.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Tested-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

If we want to overengineer the thing, it could be possible to still
declare all tests, but not build them by default. However, it's probably
too error prone and much less simple than this patch. So I don't think
it's a good idea.

Regards,
Pierrick

