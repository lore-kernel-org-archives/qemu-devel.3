Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B90AC44508
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 16:07:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk291-0005zp-Tr; Wed, 15 Jul 2026 12:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wk28t-0005z7-S1
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 12:07:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wk28q-0007Jm-H3
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 12:07:27 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66FE3SdP4006795
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 16:07:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5qotmgPsfkgCHuU+j1M/FHJPkSu+N8BIl1jhMQMztoo=; b=LMViIxWgb7+IQj5L
 DVBUq+lVYeLTRlHi2rOsI/Qpz0sGbTq3LAmkmNBJtSU8cXcVzb7MH7c1mS+Hof3I
 6bLWRGA6imnmpGQegOb30i210aw7lrDpd/E4faht3HyzNST90fbLiWlu2wVAdfH9
 WFlOmKqVi38MTq5zGreN2JgnxjMVrOCl7VdJ3ykWPi6t+/08AxVxvibiOAQWob18
 3BLSF6HBbNCC0+fiBy8aKkcwCyYg21M6uvnqaPRXS11g/7Cc46X6WFyVFWks0KFx
 DtN5FsALjcf8lZRn1jH4oPWJ5WyPM5r1ctWxSgfmAw3l9DROqJx0ALop8AHsdhfz
 XO30HA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe652a3cm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 16:07:21 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c85798977dcso5573293a12.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 09:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784131641; x=1784736441; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5qotmgPsfkgCHuU+j1M/FHJPkSu+N8BIl1jhMQMztoo=;
 b=TL1bzzTDIDuAeBoUNtMDuGPOJA9+ewOaR3TVU9JV3LTubhwk8Fez8ZW8g+qV/d0szF
 lCb/aFT0vhPxXBYqPkXpypmsqtSHCQr2GZ+5KuHptGkNWtYYolkBOG6ynGimq62Rpe18
 mGa3p8sEMKEW8LPLp8sK6iJS9ERdkc5A5lw3BJ61/hArmA2rKQ+8eZND7Bv1M1mK8a35
 9/XR3AAxRw87GwQcsiP3l5HltMCjyFwk+oJxvDqjll+Tm4HsIJ2IgxvN0ftG9DDmG+a1
 J8zKsI2WeVXsHLZNf06warHp7aYS3lGKt/mX8AUl2b372oUXCCbnFoxhpXKSnagzsubr
 SLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784131641; x=1784736441;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5qotmgPsfkgCHuU+j1M/FHJPkSu+N8BIl1jhMQMztoo=;
 b=ODnBXOndXrf+AOF4Xw24vPEXEYcfa8e5VKQlHvQwXHK2tgx82P4Q54bg5C7Wie+bvK
 40GAZS6vf4peWfK9UmThKLlD1UyIvCStcQGjsaEv6JUPxSLxiG3jENNpTYnNwo4TytLU
 UoLakycbLXlulXeq8a+T/80fpbgwpH0ZTL9UEi6gBjxMt3uOxY/Rum+wW4bitUCnUyAa
 32M0ok3YQ3Zdxjxy6AFLFxnnSF0yzVTFz5YJIvsOvwsrfsFKnb8pWpD/6bqnGW8XGXAW
 QSaUWcFTL3OallWIdzj/ZJZUKBZhPc/RfqPKW201DKBljLlytA4LR757ZRokhKLEZpJh
 F4+w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rphi+CL1SntfnGievGIpe9rtyM499OydgzsCP+OkSIH6Xg57bHzIxRykzmq4W4qZWHm7JyK2OtJrwZi@nongnu.org
X-Gm-Message-State: AOJu0YxIvZTVZTp2+J1bP7Iz/tUyH5TzsroF9ziT2NLRSYL4xXmfTubw
 iWtJkPowYdTnAQuRfHVnSWJg7yA1uCrp1/kqfpHASM40ZtO84ayNWu080YXPX8i4JS4lTcsBaOO
 gL1ravcbvqodMzd/B+nB1B6psglsb78lTDTOcxrXSX8ZENonUcYYGfsR7Fw==
X-Gm-Gg: AfdE7cmcsYfBWBkW0XMWKNoxef9p8MYXNvOl2Q8G3mKaeHERoa13oOfjddmjAfVJKMP
 8Hb40hgQ04qxEyWDgDlyvT5+1psl4UN1MO5BBQsTePObrxaT/UZAItU5uzjeOOxeeyZiMymHHhB
 AMvuSyFvC1FcJHjXc1mCLKnZl0yG6hCiSsVGEOVapPPeiqKY+rkttGSnepVgPyVwJAnMJRjHu7E
 3SOUGr79SF7Z0FuezdKQNAPhCB4VvVL2udm3bRA5CvW9b0KCCGUtKAcZA/mPuuo/Fpcw1Le+pTe
 BLhICUm1aXSjDLiOb4C2g+w9f1aPRLoRWxqu0wq5m9IP1aEc2lct+Gof6Lxo5+S8AN4obJzcQCu
 j0HJesgcJo1CogdsGayx4P/vaGfhSJvrQdYq9pQUZZVFFH9ZkaRztehf1wLRxzvvZgglS3a98E6
 AMZNo=
X-Received: by 2002:a05:6a21:7706:b0:3b3:23a2:edff with SMTP id
 adf61e73a8af0-3c36c1d4124mr3408677637.28.1784131640715; 
 Wed, 15 Jul 2026 09:07:20 -0700 (PDT)
X-Received: by 2002:a05:6a21:7706:b0:3b3:23a2:edff with SMTP id
 adf61e73a8af0-3c36c1d4124mr3408636637.28.1784131640139; 
 Wed, 15 Jul 2026 09:07:20 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13cd403a7f7sm2612774c88.0.2026.07.15.09.07.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jul 2026 09:07:19 -0700 (PDT)
Message-ID: <e3932087-16c8-4e34-98cf-c20cf7db9531@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 09:07:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/docker: ensure container command is probed at
 most once
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20260715104218.1110301-1-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260715104218.1110301-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDE2MCBTYWx0ZWRfXw/64v8TyI3fV
 5a1Mz3uDj3wXUjnHE9DrM/ufz0o2iLMVoX5tcae2/MeOY05CsLi2gk8RK+Rg7fUIOtXhaHI+qsu
 oXq89UlUGwxM+3OiSKRt6Z9yCDyYfaLW3NuplDhhNYuZ9hTbZ54yrOje0UmQjbeSBjR3Q9Kelk5
 LRdaCynR51Q1uhCqtnaJQf0Z2b89y8qOT+y/YmduYzsX4wwuua6TQNsmXjzZHCarIsVFn4ukY3u
 LFSzwqORwEzTIirreDDMy+kqXIymPluxnEisqzGMQNKXXs7sIfH3XOfVwslrifnD+BTZ3/HlADS
 fXiQXQf59iLLgo4zPk2a7duQE0Ok6Np+ovNsi2NevwD4L91H6gJLWCUeB4zk0bXs3XMiPXi+bUm
 8rtkWM+2ptLI/Ry5MzGGdhInA7jDA5X4ffNx+NQTw7VoJf/XfaLqIgSrZK6iRKtPTOO/jpD20J/
 TlDb84U1DQ3hwOjw/bg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDE2MCBTYWx0ZWRfX4WfwRkoMQEYw
 PZWdXzjjMVBgisBwR4AN/m2ySKD8cxCFtOgcx/7+HCKctBj/IdQxwkdIJUyC8rm1Bjhg54bu4xl
 W7dhX25gGK8+O/4G4osm4uZOV73IAvM=
X-Authority-Analysis: v=2.4 cv=bKcm5v+Z c=1 sm=1 tr=0 ts=6a57b039 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=p0WdMEafAAAA:8
 a=eOTV7RKpXi4agr-MV6cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: F5cuAEjctH_WJ3C7IXJdsYi9Ox3ttR4I
X-Proofpoint-GUID: F5cuAEjctH_WJ3C7IXJdsYi9Ox3ttR4I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150160
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

On 7/15/2026 3:42 AM, Daniel P. Berrangé wrote:
> The '--engine' arg accepts either 'podman' or 'docker', which is
> not sufficiently granular to map directly to a command. This
> means that  docker.py still has to then probe the exact command
> to use.
> 
> Meanwhile the 'probe' command prints out the full command to use
> but this cannot be passed back to docker.py to avoid probing
> again, so the caching is only useful in the few case where we
> run a container directly bypassing docker.py.
> 
> Address this by replacing --engine with --command for docker.py.
> 
> This in turn requires the --container-engine configure arg to be
> replaced with --container-command.
> 
> With these changes the container command is probed at most once
> during configure and never again, while running in an unconfigured
> tree will still probe on demand.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
> 
> In v2:
> 
>  * Don't set container_command to "no" if 'probe' finds
>    not viable binaries.
> 
>  configure                     | 25 +++++++------
>  tests/docker/Makefile.include | 13 ++++---
>  tests/docker/docker.py        | 67 ++++++++++++-----------------------
>  3 files changed, 40 insertions(+), 65 deletions(-)
> 
> diff --git a/configure b/configure
> index d8bc10060e..5a8e2fd278 100755
> --- a/configure
> +++ b/configure
> @@ -172,7 +172,7 @@ fi
>  # some defaults, based on the host environment
>  
>  # default parameters
> -container_engine="auto"
> +container_command=""
>  cpu=""
>  cross_compile="no"
>  cross_prefix=""
> @@ -734,7 +734,7 @@ for opt do
>    ;;
>    --disable-containers) use_containers="no"
>    ;;
> -  --container-engine=*) container_engine="$optarg"
> +  --container-command=*) container_command="$optarg"
>    ;;
>    --rust-target-triple=*) rust_target_triple="$optarg"
>    ;;
> @@ -869,7 +869,7 @@ Advanced options (experts only):
>    --enable-debug           enable common debug build options
>    --cpu=CPU                Build for host CPU [$cpu]
>    --disable-containers     don't use containers for cross-building
> -  --container-engine=TYPE  which container engine to use [$container_engine]
> +  --container-command=CMD  which container command to use [autodetect]
>    --gdb=GDB-path           gdb to use for gdbstub tests [$gdb_bin]
>    --wasm64-32bit-address-limit Restrict wasm64 address space to 32-bit (default
>                                 is to use the whole 64-bit range).
> @@ -1291,12 +1291,12 @@ fi
>  ##########################################
>  # functions to probe cross compilers
>  
> -runc="no"
> -if test $use_containers = "yes" && (has "docker" || has "podman"); then
> -    runc=$($python "$source_path"/tests/docker/docker.py --engine "$container_engine" probe)
> -    if test "$runc" != "no"; then
> -        docker_py="$python $source_path/tests/docker/docker.py --engine $container_engine"
> -    fi
> +if test "$container_command" = ""; then
> +    container_command=$($python "$source_path"/tests/docker/docker.py probe)
> +    test "$container_command" == "no" && container_command=""
> +fi
> +if test $use_containers = "yes" && test "$container_command" != ""; then
> +    docker_py="$python $source_path/tests/docker/docker.py --command $container_command"
>  fi
>  
>  # cross compilers defaults, can be overridden with --cross-cc-ARCH
> @@ -1415,7 +1415,7 @@ probe_target_compiler() {
>    esac
>  
>    for host in $container_hosts; do
> -    test "$runc" != no || continue
> +    test "$container_command" != "" || continue
>      test "$host" = "$cpu" || continue
>      case $target_arch in
>        # debian-all-test-cross architectures
> @@ -1736,9 +1736,8 @@ echo all: >> $config_host_mak
>  echo "SRC_PATH=$source_path" >> $config_host_mak
>  echo "TARGET_DIRS=$target_list" >> $config_host_mak
>  echo "GDB=$gdb_bin" >> $config_host_mak
> -if test "$runc" != no; then
> -    echo "RUNC=$runc" >> $config_host_mak
> -    echo "CONTAINER_ENGINE=$container_engine" >> $config_host_mak
> +if test "$container_command" != ""; then
> +    echo "CONTAINER_COMMAND=$container_command" >> $config_host_mak
>  fi
>  echo "SUBDIRS=$subdirs" >> $config_host_mak
>  if test "$rust" != disabled; then
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index 4725c39807..0adddb6a5c 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -16,9 +16,8 @@ DOCKER_DEFAULT_REGISTRY := registry.gitlab.com/qemu-project/qemu
>  endif
>  DOCKER_REGISTRY := $(if $(REGISTRY),$(REGISTRY),$(DOCKER_DEFAULT_REGISTRY))
>  
> -CONTAINER_ENGINE = auto
> -DOCKER_SCRIPT=$(SRC_PATH)/tests/docker/docker.py --engine $(CONTAINER_ENGINE)
> -RUNC ?= $(shell $(DOCKER_SCRIPT) probe)
> +CONTAINER_COMMAND ?= $(shell $(SRC_PATH)/tests/docker/docker.py probe)
> +DOCKER_SCRIPT=$(SRC_PATH)/tests/docker/docker.py --command "$(CONTAINER_COMMAND)"
>  
>  CUR_TIME := $(shell date +%Y-%m-%d-%H.%M.%S.$$$$)
>  DOCKER_SRC_COPY := $(BUILD_DIR)/docker-src.$(CUR_TIME)
> @@ -41,7 +40,7 @@ docker-qemu-src: $(DOCKER_SRC_COPY)
>  # General rule for building docker images.
>  docker-image-%: $(DOCKER_FILES_DIR)/%.docker
>  	  $(call quiet-command,			\
> -		DOCKER_BUILDKIT=1 $(RUNC) build		\
> +		DOCKER_BUILDKIT=1 $(CONTAINER_COMMAND) build \
>  		$(if $(DOCKER_V),,--quiet)		\
>  		$(if $(NOCACHE),--no-cache,		\
>  			$(if $(DOCKER_REGISTRY),--cache-from $(DOCKER_REGISTRY)/qemu/$*)) \
> @@ -152,7 +151,7 @@ $(foreach i,$(filter-out $(DOCKER_PARTIAL_IMAGES),$(DOCKER_IMAGES)), \
>  )
>  
>  docker:
> -	@echo 'Build QEMU and run tests inside $(RUNC) containers'
> +	@echo 'Build QEMU and run tests inside $(CONTAINER_COMMAND) containers'
>  	@echo
>  	@echo 'Available targets:'
>  	@echo
> @@ -219,10 +218,10 @@ docker-run: docker-qemu-src
>  			$(IMAGE) --executable $(EXECUTABLE),		\
>  			"  COPYING $(EXECUTABLE) to $(IMAGE)"))
>  	$(call quiet-command,						\
> -		$(RUNC) run 						\
> +		$(CONTAINER_COMMAND) run 				\
>  			--rm						\
>  			$(if $(NOUSER),,				\
> -				$(if $(filter docker,$(RUNC)),		\
> +				$(if $(filter docker,$(CONTAINER_COMMAND)), \
>  					-u $(UID),			\
>  					--userns keep-id		\
>  				)					\
> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> index 9e18b984f4..d2f39b5645 100755
> --- a/tests/docker/docker.py
> +++ b/tests/docker/docker.py
> @@ -35,27 +35,6 @@
>  
>  DEVNULL = open(os.devnull, 'wb')
>  
> -class EngineEnum(enum.IntEnum):
> -    AUTO = 1
> -    DOCKER = 2
> -    PODMAN = 3
> -
> -    def __str__(self):
> -        return self.name.lower()
> -
> -    def __repr__(self):
> -        return str(self)
> -
> -    @staticmethod
> -    def argparse(s):
> -        try:
> -            return EngineEnum[s.upper()]
> -        except KeyError:
> -            return s
> -
> -
> -USE_ENGINE = EngineEnum.AUTO
> -
>  def _bytes_checksum(bytes):
>      """Calculate a digest string unique to the text content"""
>      return hashlib.sha1(bytes).hexdigest()
> @@ -73,12 +52,11 @@ def _file_checksum(filename):
>  
>  def _guess_engine_command():
>      """ Guess a working engine command or raise exception if not found"""
> -    commands = []
> -
> -    if USE_ENGINE in [EngineEnum.AUTO, EngineEnum.PODMAN]:
> -        commands += [["podman"], ["podman-remote"], ["podman", "--remote"]]
> -    if USE_ENGINE in [EngineEnum.AUTO, EngineEnum.DOCKER]:
> -        commands += [["docker"], ["sudo", "-n", "docker"]]
> +    commands = [["podman"],
> +                ["podman-remote"],
> +                ["podman", "--remote"],
> +                ["docker"],
> +                ["sudo", "-n", "docker"]]
>      for cmd in commands:
>          try:
>              # 'version' is not sufficient to prove a working binary
> @@ -222,8 +200,11 @@ def _dockerfile_verify_flat(df):
>  
>  class Docker(object):
>      """ Running Docker commands """
> -    def __init__(self):
> -        self._command = _guess_engine_command()
> +    def __init__(self, commandstr=None):
> +        if commandstr is None:
> +            self._command = _guess_engine_command()
> +        else:
> +            self._command = commandstr.split(" ")
>  
>          if ("docker" in self._command and
>              "TRAVIS" not in os.environ and
> @@ -411,8 +392,8 @@ def args(self, parser):
>                              help="Run container using the current user's uid")
>  
>      def run(self, args, argv):
> -        return Docker().run(argv, args.keep, quiet=args.quiet,
> -                            as_user=args.run_as_current_user)
> +        return Docker(args.command).run(argv, args.keep, quiet=args.quiet,
> +                                        as_user=args.run_as_current_user)
>  
>  
>  class BuildCommand(SubCommand):
> @@ -445,7 +426,7 @@ def run(self, args, argv):
>          dockerfile = _read_dockerfile(args.dockerfile)
>          tag = args.tag
>  
> -        dkr = Docker()
> +        dkr = Docker(args.command)
>          if "--no-cache" not in argv and \
>             dkr.image_matches_dockerfile(tag, dockerfile):
>              if not args.quiet:
> @@ -512,7 +493,7 @@ def args(self, parser):
>                              help="Docker registry")
>  
>      def run(self, args, argv):
> -        dkr = Docker()
> +        dkr = Docker(args.command)
>          dkr.command(cmd="pull", quiet=args.quiet,
>                      argv=["%s/%s" % (args.registry, args.tag)])
>          dkr.command(cmd="tag", quiet=args.quiet,
> @@ -590,7 +571,7 @@ def run(self, args, argv):
>          tmp.seek(0)
>  
>          # Run the build with our tarball context
> -        dkr = Docker()
> +        dkr = Docker(args.command)
>          dkr.update_image(args.tag, tmp, quiet=args.quiet)
>  
>          return 0
> @@ -601,7 +582,7 @@ class CleanCommand(SubCommand):
>      name = "clean"
>  
>      def run(self, args, argv):
> -        Docker().clean()
> +        Docker(args.command).clean()
>          return 0
>  
>  
> @@ -610,7 +591,7 @@ class ImagesCommand(SubCommand):
>      name = "images"
>  
>      def run(self, args, argv):
> -        return Docker().command("images", argv, args.quiet)
> +        return Docker(args.command).command("images", argv, args.quiet)
>  
>  
>  class ProbeCommand(SubCommand):
> @@ -619,7 +600,7 @@ class ProbeCommand(SubCommand):
>  
>      def run(self, args, argv):
>          try:
> -            docker = Docker()
> +            docker = Docker(args.command)
>              print(" ".join(docker._command))
>          except Exception:
>              print("no")
> @@ -651,18 +632,16 @@ def run(self, args, argv):
>                  cmd += ["-v", "%s:%s:ro,z" % (p, p)]
>          cmd += [args.image, args.cc]
>          cmd += argv
> -        return Docker().run(cmd, False, quiet=args.quiet,
> -                            as_user=True)
> +        return Docker(args.command).run(cmd, False, quiet=args.quiet,
> +                                        as_user=True)
>  
>  
>  def main():
> -    global USE_ENGINE
> -
>      parser = argparse.ArgumentParser(description="A Docker helper",
>                                       usage="%s <subcommand> ..." %
>                                       os.path.basename(sys.argv[0]))
> -    parser.add_argument("--engine", type=EngineEnum.argparse, choices=list(EngineEnum),
> -                        help="specify which container engine to use")
> +    parser.add_argument("--command",
> +                        help="specify which container engine command to use")
>      subparsers = parser.add_subparsers(title="subcommands", help=None)
>      for cls in SubCommand.__subclasses__():
>          cmd = cls()
> @@ -671,8 +650,6 @@ def main():
>          cmd.args(subp)
>          subp.set_defaults(cmdobj=cmd)
>      args, argv = parser.parse_known_args()
> -    if args.engine:
> -        USE_ENGINE = args.engine
>      return args.cmdobj.run(args, argv)
>  
>  

I still observe the same error when running make-tcg without
podman/docker installed.
bash: line 1: no: command not found

And I will suggest again to include in your series:
https://lore.kernel.org/qemu-devel/20260710214343.2065491-27-pierrick.bouvier@oss.qualcomm.com/
and detect if probe command worked or failed, and adapt behavior based
on it. Existing behavior to compare to a string "no" is a very
unfamiliar pattern for any command. `which` does not return no for instance.

You can test next patch using podman (which it seems you have):
```
podman build \
-f tests/docker/dockerfiles/debian-all-test-cross.docker -t all
podman run -it --rm all -w $(pwd) -v $(pwd):$(pwd) all \
bash -c "./configure && cd build && make all -j32 &&make check-tcg -j32"
```

Regards,
Pierrick

