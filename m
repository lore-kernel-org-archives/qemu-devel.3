Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9048BC4450A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 17:53:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjhJe-0002SP-Mg; Tue, 14 Jul 2026 13:53:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjhJd-0002SG-5v
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 13:53:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjhJY-0003Vz-U7
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 13:53:08 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EG7042852804
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 17:53:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nTftr8T9QKEjkJxkMlYt9mTBtZkqQf7y+Kxz7Wi0/pY=; b=QnMbiPohhJaB8Aoq
 TSv6qDuR/FO+x6ZLfz6eJixRGTXDZQilbhuamH6gRvsuZQ+Q25WS6NAaTes9v156
 lc2VDuI4Yiczczjrgg1PzIQ4dc/q1BOYrZg42z0fVdVb9apvOxvjkAm7clA8/k/p
 bbt7ovcxDZEKvciL0JwBXGrX58RLtqVABFg/dyGJTC5iZz7KT5zUFxPoSY32QrwO
 VNCRe/CEBaMEZ9runeWbwtWlGmGnDnTJyUAv4AqR50ikgEYwOOB1DgZPglKXxI4l
 KiLP0Mgzy2fQhwms9RIWTa0Y3doK/zRWZkXt3/h20SACAWt9X4qi9/21bbXtizmM
 yQE4mw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdmkk1hh6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 17:53:02 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c88e0d11a3fso1153581a12.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 10:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784051578; x=1784656378; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nTftr8T9QKEjkJxkMlYt9mTBtZkqQf7y+Kxz7Wi0/pY=;
 b=YjUMrV6cBDpOOX/clz0weQ1IFC43POvb6RrhKKaEkP3ro9DKAU+GgrR4JmuhDVFoaz
 WsszcNk8ZuqSH1kwCXJoMaYaTav42skIPZci2fgfafWULpLR1aNwKgezXEc35ZjcRvYS
 j0Lwqf0KepTRjXzRzOb8FVEmN2fJceMO8mBTE4llNKgop3ZYv9VaRpNIYp0gmyzARzPX
 K9LiUONQfbxgjYztOah8hvi5hOG0Mp0NuzLe5hGQBzOS/zcuDgLWNPjwmrtS9vP3TI52
 W8/+odJh+9GsPpWePXDgnpbS8+3iOTjobOE/NVZEzfyA0MRtNZ8fhhfLw2FHYlDzAWMR
 wL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784051578; x=1784656378;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nTftr8T9QKEjkJxkMlYt9mTBtZkqQf7y+Kxz7Wi0/pY=;
 b=hIw/UrTRH3Y7FFJuiekdmhmJw7M70+g9XKph9NaIjNDFDO3CkC0Qgodjf95//Wupfr
 ZdS9nqX9k4umOuVyMrdwI7Q5vqnvVjZb+VmEniZmR+23YlG3YKxw18JJaw5zuvMhLhkp
 rBmaQFjAYcPGupMgiEgqkSlywEaWM5lzTEzMSdpXaKvTFdehdFWTDLa1OzeggzvRYM4D
 ILY1ukZrG/CpF50mXwT7NStzsGJ7sgLiKml4f8gGISbdCTH6B2SJFH7xTGdQ979JUg+w
 /zegBdqrY0Z8z3YzfxUEg8tsD0WGjRY2TmXk4QzaL18qpAUP8KJJG9C36/835PEuNZFQ
 Fnpw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpF5rvh7rfiKYwej1OCO12C2qWWLJ6mpgdnnoOhF6DTay+hp6xXhi8sIN9VyeBG4LU1out1ojSHkBdU@nongnu.org
X-Gm-Message-State: AOJu0YyXSgvq+Ja2SV86/x7p/l/mfvEJ7DRwvOEMNQJhJvy6V6KSdQ9E
 IGE7tIdZZ3nIxMk0zZhmbUKYX8MlKMJfEAQ5s4ZL5GEz4hDQsHKnkXNhwC1fieUUhct48AE+5kZ
 1BzKZI1FmTYSHyMjZ0vFGOquTsIwwm1le/Xvb1HjskQ3eb3cpukLc4TYY7w==
X-Gm-Gg: AfdE7cnbimgvJYbIboEaAe0PsQ9GEFUsOnYWAWbO3eokyf4pu/y79CG3/RSjRvXQKh4
 J82usYwAe6iZyyl2wNnXTSbQ4+tE3PXwIOP0QE3L6Q+vg5WaCemWk7+S4ENeG2+d+3h9yiG9VNb
 d7s8sXo/rtrPvzH5e+8TPEG1fRx9Ih3NzlScarKgUO90A+w1ChFgsky0QsYukkA+ud15YQYJH4E
 gorCD24KpUbVYZJ26GL7npm7kAZ1wtTj0MqjTW6KFwhpbmwE8qC9j9E7/EzB56E8dpOJAcRNpID
 mV6gML9PyOepJVnAAoKnmG/FnH/n69JmLENxRaOjfOUaLUc/YKBQwklVidie/OQq1tdI49f85Ik
 10fTWcAVFzGuMz9Xufb+fyO/vcA8s8feeFZtJzYZn5OkMg0mVlRjG9j8Rm9wzO3tAriyYIrDgaa
 891NQ=
X-Received: by 2002:a05:6a21:3405:b0:3b5:a008:683c with SMTP id
 adf61e73a8af0-3c110b263d1mr16433988637.45.1784051577548; 
 Tue, 14 Jul 2026 10:52:57 -0700 (PDT)
X-Received: by 2002:a05:6a21:3405:b0:3b5:a008:683c with SMTP id
 adf61e73a8af0-3c110b263d1mr16433944637.45.1784051576923; 
 Tue, 14 Jul 2026 10:52:56 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3118389d9bcsm70835611eec.20.2026.07.14.10.52.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2026 10:52:56 -0700 (PDT)
Message-ID: <9bed22c3-4f35-4d87-82da-6e10eb1df461@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 10:52:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/docker: ensure container command is probed at most
 once
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20260714114057.653982-1-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260714114057.653982-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: PSDE_Vwd0SuFmtNG442J8wLoe2lsyknx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE4NCBTYWx0ZWRfX6ehDsgWp5wAJ
 Iw8cnNU+sFLvhIz54eGgPEivSADdYaNu50Nl3x/USsMHgOTk4w50zOa4bYJkSH2Dv6RFN9vakzR
 LChLTV1oxUagVd1xZEa+e/tgVAydCjIfpdCU3URa8LakBRw9SZdiJ5Oa9KGedagYxl6w4G79Pbf
 TpCicYJSMX3lk7K5kh7TevFH2Ez2lDEH3V8HuRW2+KGlJLfrPKADPx6oakrs12nERjoJVASVERV
 u9HPEHf3rdyLrpDqaVaDDEXAhQeL0dc2N5MsA1dP907zKOGVTxe8hiPCEn5Yf9pA5SPZi2s4MkO
 fdAGl4oNHxXoKdlwQB95Zxerh/fXs4Sjh5Xl9b+8UofT5mB/YmG4VmgFq1Leiaw00CLuskhiiCv
 OS/J3H7nfgKdtREBh97mpxJxkKatL0mChw1tJ2k9DL99Ml6VruVyikKEkvglWHkq/lHVz24HDeU
 btuVMFMJSaavk6RWXlw==
X-Authority-Analysis: v=2.4 cv=NszhtcdJ c=1 sm=1 tr=0 ts=6a56777e cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=p0WdMEafAAAA:8
 a=eOTV7RKpXi4agr-MV6cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: PSDE_Vwd0SuFmtNG442J8wLoe2lsyknx
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE4NCBTYWx0ZWRfX5VtBg6xlh8fx
 ZwyetVJZ6AfVhua4FuJoNFYyehHR9xEUXIzuYaKpd5OCSslj/C2SxReWPX+A2kzknKVpsXGR8FS
 274O7+KIKh/GINmw8fjJJYCz8LVN2xw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_04,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140184
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

On 7/14/2026 4:40 AM, Daniel P. Berrangé wrote:
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
>  configure                     | 24 ++++++-------
>  tests/docker/Makefile.include | 13 ++++---
>  tests/docker/docker.py        | 67 ++++++++++++-----------------------
>  3 files changed, 39 insertions(+), 65 deletions(-)
> 
> diff --git a/configure b/configure
> index d8bc10060e..6602fc3004 100755
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
> @@ -1291,12 +1291,11 @@ fi
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
> +fi
> +if test $use_containers = "yes" && test "$container_command" != ""; then
> +    docker_py="$python $source_path/tests/docker/docker.py --command $container_command"
>  fi
>  
>  # cross compilers defaults, can be overridden with --cross-cc-ARCH
> @@ -1415,7 +1414,7 @@ probe_target_compiler() {
>    esac
>  
>    for host in $container_hosts; do
> -    test "$runc" != no || continue
> +    test "$container_command" != "" || continue
>      test "$host" = "$cpu" || continue
>      case $target_arch in
>        # debian-all-test-cross architectures
> @@ -1736,9 +1735,8 @@ echo all: >> $config_host_mak
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

This looks good, but it fails to run tcg-tests on a machine without
podman/docker, with error message:
bash: line 1: no: command not found

You can include this patch in your series:
https://lore.kernel.org/qemu-devel/20260710214343.2065491-27-pierrick.bouvier@oss.qualcomm.com/
and detect if probe command worked or failed, and adapt behavior based
on it.

Regards,
Pierrick

