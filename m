Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F07E8C982C1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 16:50:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6spL-0007LO-Sd; Wed, 16 Sep 2026 12:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6spK-0007JG-Dj
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 12:49:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6spH-00016u-Ke
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 12:49:42 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GFeQJF1855016
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 16:49:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nbKSKlpR9/Wz4BX9Dl9fcrMyp5vqJRmWMp1I/A4o7ek=; b=VdC1rMsElmhmukRp
 jE8ZkBJOF4c8pugNPNjEByAGLAN2Mwf+x73EIUoAU0vycNWAlGRuQ9/9qNmRCfeP
 eHvL8jrjZJdj5AaXaeyNDlOT6lC8sGdo4uHTix8B63fKGVuk4wcNDn4qtrX0ogFp
 jNrg4RWIP1EPGrZz7xK0lCwMeehs7gObyVzrJiggox9F8JQ3OEN4x9Kyb11vzsJg
 gW005KyKpS3gsWOJRa0F0YeKtnjBi6lAmTJ2QFMF/xyKKjg80++XhjNZCEJwZIjN
 WiUUNNdFiHRfbGnlOSGl7QpCJipVnYSV9EeMusgeseTCkuinyI/w3B3mbjzhGsQo
 ZjPjmg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqqp3t4f6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 16:49:38 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cee1ec30f2so70220975ad.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 09:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789577377; x=1790182177; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nbKSKlpR9/Wz4BX9Dl9fcrMyp5vqJRmWMp1I/A4o7ek=;
 b=Rg9ymN/Y8AEOdKkQtqf+hWDbtxHvBrwIB3lZ+GUY52U+zQOPyOMrzFFyJgN/3SAZPV
 OfoCIohPQmW5/S4yLdlqzs6esk0UEPOLdLkBkBOgjrkqKqUf/8QmCO3P3xXPwZ+6DZn0
 2FzlsOzz/b4f0gybvzuyb9jCj4DtNuz6HKaeJu6q9Ihgaec0InIiqWWQrAMxffzNTlVv
 O3WmqvJyXx+z9TKiZy3fPuUsFEDKJYeiK1fwj/LxEAOtcHhixSI8aR/KvylSQTc32s8X
 S55h6MOGI5L7GVk5r+iN9uHLOteb8gaKBoNA3tgmoJW9SFUijx5selwcA/MzpzNjKPa5
 Z/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789577377; x=1790182177;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nbKSKlpR9/Wz4BX9Dl9fcrMyp5vqJRmWMp1I/A4o7ek=;
 b=RG4anoJdWj9wK3L5VZrgc5LbLKELtA270qSOZkXNacrF6fHSacdgtk3y2H0AxIKm7C
 RHTfdo+y6cR+u60eq3K7j1O9m/GrdW9YbqyQctlDOFMEtEup26zp+px5UIDDSrU30/V6
 Rhn3MwiaJgp5Lgde/wxB8H4pYV4/B/cHxwW8GixdLtp29JpG1ldGgtogam8ACm+dI7GL
 xZYUzlvHozACMaNu654OINJrTkc18jT1njH5LX1QUNue21jyFOskJ38PLOjp7kIqZQFc
 hV6pxNwwM+JpOAbgVP9GM2//WK2NOT5Yd9fF3QI4DAIYtcpZbv+F08ZiqmKNsBxhRS3K
 +ujw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwx9oBlzSgsFzUlFxa97vKS6K+zJtY8dxMvj27fAd1v/da1+5qf1OZxhs08toEy/gxuRtxu9ti9Mla8@nongnu.org
X-Gm-Message-State: AFuF++lY8QqnozdTxsQruwiTGAp/RGL+foGSZ0+ja+gMLrJsI2IDW1Sr
 mRzP+Fs5fXzxxaeVdjpLqAup8y7ru2n3up4cMFPhLkhrY0GE+O0gQqWuCKk7MOZ1R17UKVmRdeE
 dgsuYzjeO5UpkyL8J8Ryr1Gad3OCNx3Ht2HEuXCSnFxVmxLNv6hN+Wa6LHQ==
X-Gm-Gg: AYBFou1Ni4KKJPsvkQ7pa8taxWkkDToQHEEGEHjTXVw62hOkJ1Qm2IaERVHsoPaxI/5
 6UtJKuRj39JeV/9boSamRn5kUHGuEaOOY5R2+SB0RF5qTJwFDLImpJS6K2b+wA1S/vsf5iZAKIl
 5OHv/KmuxuGMGU/Ymxh6sK/1t+3rgZRllc2TeFtVhcAlM7p9IF0eTEXurVHKfLc7/iq4/NAbwq/
 4UNH5qhjudC117nK7bUkWtSRTu6EW95X4CWGut3yFmQOvA7896M2V0jxkVXAC6PJHNyFApT4Grs
 +VqhOTSx6zuTMxBnwEYDMfShpkP5INkgEiVeVAvm6XdqK2WPhs2R9u81kmst22VtGZ+k2iTT3n0
 lxAMRrQsbbmpLg+txlj9LvLEwsBybHm9ni4o6Sw7K6mBmhaDah+sb0172xJwfFJqtCvD1
X-Received: by 2002:a17:90b:384c:b0:39d:8794:5564 with SMTP id
 98e67ed59e1d1-39e1e48a48dmr7145419a91.12.1789577377256; 
 Wed, 16 Sep 2026 09:49:37 -0700 (PDT)
X-Received: by 2002:a17:90b:384c:b0:39d:8794:5564 with SMTP id
 98e67ed59e1d1-39e1e48a48dmr7145188a91.12.1789577375273; 
 Wed, 16 Sep 2026 09:49:35 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d5d0f3sm7642100c88.12.2026.09.16.09.49.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2026 09:49:34 -0700 (PDT)
Message-ID: <6c5f7980-cf55-4b9b-b74a-19a6b8c732c9@oss.qualcomm.com>
Date: Wed, 16 Sep 2026 09:49:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/19] tests/docker: swap --quiet for --verbose
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, qemu-arm@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 John Snow <jsnow@redhat.com>, David Hildenbrand <david@kernel.org>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Warner Losh <imp@bsdimp.com>, Song Gao <gaosong@loongson.cn>,
 Kyle Evans <kevans@freebsd.org>, Eric Farman <farman@linux.ibm.com>,
 Brad Smith <brad@comstyle.com>, Fabiano Rosas <farosas@suse.de>,
 Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-s390x@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260916153013.2134555-1-alex.bennee@linaro.org>
 <20260916153013.2134555-15-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260916153013.2134555-15-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDIzMCBTYWx0ZWRfXzewcKxm8El3+
 HsKxF3mZfpw84U01PhMd7W3UcHKkItQsplIYTQq2A8o9UfVoGXPiMdOK8la28wl7ugtyAT+swOk
 MfAFlk+GKP1cxo5ZtTLwUvLGKi+B5LZm25rlTSZZQ0/c6crBnbZ8WRxHq9hNoOYJJ/d8npIq3yC
 aR+V6HC0BMnHYohrlCMryUy9g1bfJxPcNanmIoeVldyy4/ArsOQGtwul8XyFXFu1EU6ro0si/tT
 YMKtn5CEQVN+OUQTIDlhKyy0+Z53MA9XXDtdmUQI8oH08wVR2MJrFEvJB2adGVPGAP9pfygTgVQ
 FX0tARU+VNCSf87//u9546MGz/2n7RKB39J4eyWALd9lUZLUeqmXXOAMpBP6D56UXF0LWpisJJ0
 7Ix70p2SNSY3CZVB6b99dgWaEaVEG/rlNCTEis91d4HF74IT/1rBxhP9m+DpoT1Pz1pmXSFwxIW
 B09WaTxShaIlRgu3XmA==
X-Proofpoint-GUID: HPD-2sn-86RisKWGELKMaTaU5POI2qZs
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDIzMCBTYWx0ZWRfXwCa5m3uHwVHC
 IHMmOqF7ONGVKLFZka98j/u+0Rrr2dfvfTNj2y587jPdqSKtb8wco2AgoNh/R9wWcqyD/hMZSNP
 dZa8ZG/MQFc8ZvjIxjjKrN48ikhQhhE=
X-Proofpoint-ORIG-GUID: HPD-2sn-86RisKWGELKMaTaU5POI2qZs
X-Authority-Analysis: v=2.4 cv=F/DC5ahN c=1 sm=1 tr=0 ts=6aaac8a2 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=dmxABcaeaIdBPb2-SMsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1015
 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160230
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=unavailable autolearn_force=no
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

On 9/16/2026 8:30 AM, Alex Bennée wrote:
> Running the docker build in meson spams the output so default to quiet
> and make --verbose the options. If we want to expose verbosity in
> meson we can deal with that later.
>

It "spams" output only when build is really done. If image is already
built, then it's silent. I don't think it's worth silencing this
completely by default. Maybe we can postpone this patch to when it will
be correctly integrated with meson, there is no emergency or fix here.

> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v3
>   - dropped accidental libvirt-ci inclusion
> ---
>  tests/docker/Makefile.include | 10 +++++-----
>  tests/docker/docker.py        | 22 ++++++++++++----------
>  2 files changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index 74bf471f171..85825d74dfb 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -72,13 +72,13 @@ docker-binfmt-image-debian-%: $(DOCKER_FILES_DIR)/debian-bootstrap.docker
>  			DEB_TYPE=$(DEB_TYPE) 					\
>  			$(if $(DEB_URL),DEB_URL=$(DEB_URL),)			\
>  			$(DOCKER_SCRIPT) build -t qemu/debian-$* -f $< 		\
> -			$(if $(DOCKER_V),,--quiet) $(if $(NOCACHE),--no-cache) 	\
> +			$(if $(DOCKER_V),--verbose) $(if $(NOCACHE),--no-cache) \
>  			$(if $(NOUSER),,--add-current-user) 			\
>  			$(if $(EXTRA_FILES),--extra-files $(EXTRA_FILES))	\
>  			$(if $(EXECUTABLE),--include-executable=$(EXECUTABLE)), \
>  			"BUILD","binfmt debian-$* (debootstrapped)"),		\
>  		$(call quiet-command,						\
> -			$(DOCKER_SCRIPT) check --quiet qemu/debian-$* $< || 	\
> +			$(DOCKER_SCRIPT) check qemu/debian-$* $< || 		\
>  			{ echo "You will need to build $(EXECUTABLE)"; exit 1;},\
>  			"CHECK", "debian-$* exists"))
>  
> @@ -103,17 +103,17 @@ debian-toolchain-run = \
>  	$(if $(NOCACHE)$(NOFETCH),					\
>  		$(call quiet-command,					\
>  			$(DOCKER_SCRIPT) build -t qemu/$1 -f $< 	\
> -			$(if $(DOCKER_V),,--quiet) 			\
> +			$(if $(DOCKER_V),--verbose) 			\
>  			$(if $(NOCACHE),--no-cache)			\
>  			--registry $(DOCKER_REGISTRY) --extra-files	\
>  			$(DOCKER_FILES_DIR)/$1.d/build-toolchain.sh,	\
>  			"BUILD", $1),				        \
>  		$(call quiet-command,					\
> -			$(DOCKER_SCRIPT) fetch $(if $(DOCKER_V),,--quiet) \
> +			$(DOCKER_SCRIPT) fetch $(if $(DOCKER_V),--verbose) \
>  				qemu/$1 $(DOCKER_REGISTRY),		\
>  			"FETCH", $1)					\
>  		$(call quiet-command,					\
> -			$(DOCKER_SCRIPT) update $(if $(DOCKER_V),,--quiet) \
> +			$(DOCKER_SCRIPT) update $(if $(DOCKER_V),--verbose) \
>  				qemu/$1 				\
>  				$(if $(NOUSER),,--add-current-user) 	\
>  			"PREPARE", $1))
> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> index d7eb4cf6811..10cb4cbde11 100755
> --- a/tests/docker/docker.py
> +++ b/tests/docker/docker.py
> @@ -312,8 +312,8 @@ class SubCommand(object):
>      name = None  # Subcommand name
>  
>      def shared_args(self, parser):
> -        parser.add_argument("--quiet", action="store_true",
> -                            help="Run quietly unless an error occurred")
> +        parser.add_argument("--verbose", "-v", action="store_true",
> +                            help="Run verbosely (default is quiet)")
>  
>      def args(self, parser):
>          """Setup argument parser"""
> @@ -341,7 +341,8 @@ def args(self, parser):
>                              -- to avoid confusion about its flags""")
>  
>      def run(self, args, argv):
> -        return Docker(args.command).run(args.cmd, args.keep, quiet=args.quiet,
> +        return Docker(args.command).run(args.cmd, args.keep,
> +                                        quiet=not args.verbose,
>                                          as_user=args.run_as_current_user)
>  
>  
> @@ -390,7 +391,7 @@ def run(self, args, argv):
>          # Is there a .pre file to run in the build context?
>          docker_pre = os.path.splitext(args.dockerfile)[0]+".pre"
>          if os.path.exists(docker_pre):
> -            stdout = DEVNULL if args.quiet else None
> +            stdout = None if args.verbose else DEVNULL
>              rc = subprocess.call(os.path.realpath(docker_pre),
>                                   cwd=docker_dir, stdout=stdout)
>              if rc == 3:
> @@ -416,7 +417,7 @@ def run(self, args, argv):
>                   for k, v in os.environ.items()
>                   if k.lower() in FILTERED_ENV_NAMES]
>          dkr.build_image(tag, docker_dir, args.dockerfile,
> -                        quiet=args.quiet, user=args.user,
> +                        quiet=not args.verbose, user=args.user,
>                          argv=argv, registry=args.registry)
>  
>          rmtree(docker_dir)
> @@ -435,9 +436,9 @@ def args(self, parser):
>  
>      def run(self, args, argv):
>          dkr = Docker(args.command)
> -        dkr.command(cmd="pull", quiet=args.quiet,
> +        dkr.command(cmd="pull", quiet=not args.verbose,
>                      argv=["%s/%s" % (args.registry, args.tag)])
> -        dkr.command(cmd="tag", quiet=args.quiet,
> +        dkr.command(cmd="tag", quiet=not args.verbose,
>                      argv=["%s/%s" % (args.registry, args.tag), args.tag])
>  
>  
> @@ -513,7 +514,7 @@ def run(self, args, argv):
>  
>          # Run the build with our tarball context
>          dkr = Docker(args.command)
> -        dkr.update_image(args.tag, tmp, quiet=args.quiet)
> +        dkr.update_image(args.tag, tmp, quiet=not args.verbose)
>  
>          return 0
>  
> @@ -532,7 +533,8 @@ class ImagesCommand(SubCommand):
>      name = "images"
>  
>      def run(self, args, argv):
> -        return Docker(args.command).command("images", argv, args.quiet)
> +        return Docker(args.command).command("images", argv,
> +                                            quiet=not args.verbose)
>  
>  
>  class ProbeCommand(SubCommand):
> @@ -574,7 +576,7 @@ def run(self, args, argv):
>                  cmd += ["-v", "%s:%s:ro,z" % (p, p)]
>          cmd += [args.image, args.cc]
>          cmd += argv
> -        return Docker(args.command).run(cmd, False, quiet=args.quiet,
> +        return Docker(args.command).run(cmd, False, quiet=not args.verbose,
>                                          as_user=True)
>  
>  


