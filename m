Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A3E0C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 23:00:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05Xb-000069-Iz; Fri, 28 Aug 2026 18:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05XZ-00005C-T6
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05XU-0005i6-LP
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:17 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SMTuFB3186282
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=GsH1bsVvXhSpk+3Qotf0f1
 FCFgqTtRGJb7AdHQiLFuQ=; b=MyyKU/yICH6eW2G/pRKKWsPwX7il4/x6CAOnoC
 s6VPbJ9rHnqT1vwe9AH509eYaWl+18Rm4/Gb9jPZd9IC1gp9E8ER+pAiNAnrwL+9
 MR8aqSKWExU7kBToZml8VyrZ/g0edzWEGjMCaHZmKTArmJZlAGYaRE7nRd4+wxSy
 TjJ/VEyAJmrkXsI3fwQjjmstUBXIYW7BuHcYCHfjAonz9wwtNv3NXB84S4T/ce2/
 zjvl3fBJrkEXEZvvc3ZTAujsLxI1QV5+oWVddZNVIF6S8OUm4F3DFxSWfNSaHLQ7
 EUNH4VA4JqOwEJU4m/noiwJHBMcn6Nj7HlYtbBcpcujWylAw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbag9t2pv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:05 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-381250979d5so1940568a91.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787957945; x=1788562745; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GsH1bsVvXhSpk+3Qotf0f1FCFgqTtRGJb7AdHQiLFuQ=;
 b=hYxobFII2WbNJcdGnfPPgivUfp/ecf/7/Ar2Hvp/w8omFINQAcm5uht2pDatj80rHC
 VFfaoGo9lm8uirFEno8IKn7WE5Ivm0iez1Ik2AUTlksXsV+NKqxfIIBd69JWmKLwI7kn
 8GQRNlUDz63cgnKqeUA1wGpqrgBwVRH+Tc4GOQ+8ui+IBGiq9Z52q0NTCYTui+CbnwbE
 oBDmaKu2An4KSATs6ilMPXEgJsxRC/kduAFIUO1lIQXPWAl/csd/UFfaFV1QmjMtOEff
 IdavpdgC59gP/AcyMK/+DLk2y1nY5338LaFkEHj2rx/3b/pX28vlCsB5nnbWpWFDj8Pz
 Fifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787957945; x=1788562745;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GsH1bsVvXhSpk+3Qotf0f1FCFgqTtRGJb7AdHQiLFuQ=;
 b=pY/yu6PtNHkT7Fo+oJ6tuqi7lSs/9/rC4lhGiheqVsCGj6aBykLJx2q0awHx8PM5NR
 pR3H+vk2OGmkr88Cmfi5bmTki6ZV2F4blGnhMzsuMwSO2WHzUk6yGy8r20rwT+uHkkFA
 jqmXIRqS/KFF61e4WxZ+bW6yvEUdHJct3Z/tLjdtR8bbrnnWxOg++eWfD6kg1bBFH5vk
 Gnsz3Tf2s3yEMUEfCrsMsP8MHta4ubaLEtNVAR5G1da2/83+b5rgvUxoS1UvVNfqNv9s
 sR4u2LBAB97z46y8zhTyEQYeLxgvxdtpOQfJ3cR26DN7jrxS3FWtl52JCeyCZ6akJoHf
 Sitw==
X-Gm-Message-State: AFuF++msAcpDlxCrL0VM5WQzeJiW/gBCx1S9cv2AnHKT2OdmndDNf5ZV
 yXl19GtblfM8YcoZ2OXFXAbWMkObMAF3YpV3UGgjYiS/G3EOtEjSLcPLqGy66oWLwcBlCJ8uALa
 ao/3GkkwOGvEcCUsSErcqalhh+xlHO0V6deCng6HrcjB/6AF8EZd68CZWxIwpBvqYbQ==
X-Gm-Gg: AYBFou2Ibhf9y9ULZQ1O7OnYPKUCZEhWtW9a4WjVB7ny9nx27QuIye20B+hN8Ry8kvi
 TmJ3rpuFyYp5uRRvdExo5IRsxkQLZ/bVzcS4uwe+BevuNf7Kkj9Xrt4+hAKcOLzfvQEbr4UsqhJ
 n2TeU6aUDrvQmTUJSna08MQ7ZYrwV6mpDO0iqbdDONR3aXjuer26wOstSJ+ZrIznQC1uhbwq33U
 mRwLomco0UcOB0uL3KQCgC5KN9Mpa2BHrH+9LmRohdR3FJp95s2EyMeLw4EEMjhRAzdSbdGJljU
 RHm510at7oMrptu5KycANaAWgXEeDBin3uxhIdoHtDou9ga/x1RxYKcUyllxOa9VTB0eLmC7AF8
 SS4YLDNpw/eW+yud8tZWvZtlnxlIMwBlRqBdGmaX+wQcUqhSvZlM/dT6EyzE=
X-Received: by 2002:a17:90b:3c8c:b0:38f:efed:5448 with SMTP id
 98e67ed59e1d1-396d0e7255bmr19435986a91.8.1787957944749; 
 Fri, 28 Aug 2026 15:59:04 -0700 (PDT)
X-Received: by 2002:a17:90b:3c8c:b0:38f:efed:5448 with SMTP id
 98e67ed59e1d1-396d0e7255bmr19435901a91.8.1787957943962; 
 Fri, 28 Aug 2026 15:59:03 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0de4de3sm12862827c88.12.2026.08.28.15.59.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:59:03 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 00/47] single-binary: implement dynamic filtering for QOM types
Date: Fri, 28 Aug 2026 22:58:14 +0000
Message-ID: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=UalhjqSN c=1 sm=1 tr=0 ts=6a9212b9 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=dbybfE0GEL4djeLsQOoA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfXwYF2/1iTScAb
 a2A1MsVNLq+nj62jSO3R61pBRx+F9STWqjZFEBVzhWPj5UYO9Q3Y4svFFOlf6PSyUvRHc73ItgO
 gDohMrvKQn6HcvCX40o0CLo7ZpGFcGw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX0go8nZgaCTjH
 wPVUop96tLSfq39Q1Wj0UOkDBXX4cC937FDwUuGVgg+3Z4vO9nwkmvcdlYA8VdfdtWkAePe7rHp
 Ep9+/jgstJdJCkxVcR+ATLXHzL+9SncB5ukkbqgBw/vnJ1sebkBht6DjA4cAXJM9Sw044+gXLuC
 q4IqoEMSruML2pVGUP0dTCW3mwCvCynV5DwMkSq+9ZAJZ1HXbs76wy5LpmtWsrwzbgXiLAzo9ee
 JzLaLAI84lKIIDKy0s07sGa6jsrDapFTjiLp/U4jR6Zu15KNM6pwZenYrOUZwGRMMIFbIUG0Y2M
 O+E3YcBoyMRSgGaeTf4AQ6974Bt2BRoJCOvf+JvIFdHrBu0kbkg6MZvY+7hwkffadBuPWECcSti
 4swRCUcEb4PPappUjlmhAXE3bCJmu9pJbuf8U44PggS/bRFSr1gj8wc22Hn0LAhCTfBFgJ0pd9j
 kJt5yd4QICTgLegRFfA==
X-Proofpoint-ORIG-GUID: MiVVXXjyYIcBco8pDKLrF4ZTV78Pk26n
X-Proofpoint-GUID: MiVVXXjyYIcBco8pDKLrF4ZTV78Pk26n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_07,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280200
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

Now that we can link a single-binary with at least two targets (arm, aarch64),
we want to make sure that we expose the same set of machines (later devices and
cpus) than target binaries. For that, we implemented a static filtering based on
target interfaces that each machine will implement to declare which targets have
this machine.

However, we discovered that this static filtering is not enough. Indeed, some
machines and devices do not depend only on target, and their presence can depend
on Kconfig or host/target combination. Thus, our static approach can't work, and
we need something more flexible.

The goal of this series is to focus on the filtering mechanism, not on the
qemu-system binary itself, even though it's included here to give a full picture
of what we are building.

v3
--

Suggested by Richard, we simply use a callback added to TypeInfo.
Added full example with a single binary for arm+aarch64, and then
arm+aarch64+microblaze.
Also, added scripts/single-binary-compare-cmdline.sh, which compares list of
cpus, devices and machines between single-binary and original binaries.
This is what we can use in CI to ensure we correctly tagged all QOM types.

v2
--

Suggested by Daniel, we share a list of requirement for type to be available,
for future introspection needs.

v1
--
This series adds a new TYPE_TARGET_SPECIFIC, that declare a single function
bool is_available(void). From there, any machine type (and later devices and
cpus) can implement it to override their presence for each target.
We first replace the existing static mechanism with this, and once done, we
cleanup all the old interface. One nice benefit is that we can get rid of
config/targets/*.c files, which saves duplication.

Pierrick Bouvier (41):
  hw/remote/machine: remove unsupported arm target
  single-binary: command line reference
  qom/object: add is_available callback to TypeInfo
  hw/arm: filter minimal set of machines
  system: query machines using TYPE_MACHINE
  target-info: remove machine_typename
  configs/targets: remove target info definitions
  target-info: rename target-info-stub.c in target-info-def.c
  hw/arm: remove TYPE_TARGET_{AARCH64,ARM}_MACHINE
  hw/arm: remove {arm,arm_aarch64,aarch64}_machine_interfaces
  hw/arm: remove DEFINE_MACHINE_{AARCH64,ARM}
  hw/arm: remove machines-qom.h
  hw/riscv: remove TYPE_TARGET_{RISCV32,RISCV64}_MACHINE
  hw/riscv: remove {riscv32,riscv32_64,riscv64}_machine_interfaces
  hw/riscv: remove DEFINE_MACHINE_{RISCV32,RISCV64}
  hw/riscv: remove machines-qom.h
  target-info: add target_config_multiprocess
  hw/remote/machine: filter from CONFIG_MULTIPROCESS
  target-info: add target_config_nitro
  hw/nitro/machine: filter from CONFIG_NITRO
  hw/arm: filter aarch64 only machines
  target-info: add target_config_dpcd
  hw/display/dpcd: filter from CONFIG_DPCD
  hw/nitro: filter from CONFIG_NITRO
  hw/remote/proxy: filter from CONFIG_MULTIPROCESS
  target/arm: filter cpus from target
  system/vl: add new option -target
  system/vl: fallback to detect target from argv[0]
  meson: build single binary for arm+aarch64 targets
  scripts: add single-binary-compare-cmdline.sh
  hw/core/boards.h: add available callback to DEFINE_MACHINE_EXTENDED
  hw/core/boards.h: remove unused DEFINE_MACHINE_WITH_INTERFACE*
  hw/core/boards.h: add available callback to DEFINE_MACHINE
  hw/arm: filter arm machines
  target-info: add target_microblaze
  hw/microblaze: filter microblaze machines
  target/microblaze/cpu: filter microblaze cpu
  hw: filter arm devices
  target-info: add target_config_cxl
  hw/pci-bridge: filter from CONFIG_CXL
  meson: add microblaze to single-binary

Richard Henderson (6):
  target/arm: Move -cpu max stuff out of cpu32.c
  target/arm: Build cpu32.c once in system mode
  target/arm: Rename and adjust aarch32_max_v8_tcg_initfn
  target/arm: Introduce cpu types max-v8 and max-v9
  target/arm: Use -cpu max-v8 with aarch64=off
  target/arm: Separate cpu types max-v8 and max-v9

 cmdline_ref/qemu-aarch64.cpu_help             |  16 +
 cmdline_ref/qemu-aarch64.help                 |  50 ++
 cmdline_ref/qemu-aarch64_be.cpu_help          |  16 +
 cmdline_ref/qemu-aarch64_be.help              |  50 ++
 cmdline_ref/qemu-alpha.cpu_help               |   8 +
 cmdline_ref/qemu-alpha.help                   |  50 ++
 cmdline_ref/qemu-arm.cpu_help                 |  26 +
 cmdline_ref/qemu-arm.help                     |  50 ++
 cmdline_ref/qemu-armeb.cpu_help               |  26 +
 cmdline_ref/qemu-armeb.help                   |  50 ++
 cmdline_ref/qemu-hexagon.cpu_help             |  13 +
 cmdline_ref/qemu-hexagon.help                 |  50 ++
 cmdline_ref/qemu-hppa.cpu_help                |   4 +
 cmdline_ref/qemu-hppa.help                    |  50 ++
 cmdline_ref/qemu-i386.cpu_help                | 259 ++++++++
 cmdline_ref/qemu-i386.help                    |  50 ++
 cmdline_ref/qemu-loongarch64.cpu_help         |   4 +
 cmdline_ref/qemu-loongarch64.help             |  50 ++
 cmdline_ref/qemu-m68k.cpu_help                |  11 +
 cmdline_ref/qemu-m68k.help                    |  50 ++
 cmdline_ref/qemu-microblaze.cpu_help          |   2 +
 cmdline_ref/qemu-microblaze.help              |  50 ++
 cmdline_ref/qemu-microblazeel.cpu_help        |   2 +
 cmdline_ref/qemu-microblazeel.help            |  50 ++
 cmdline_ref/qemu-mips.cpu_help                |  19 +
 cmdline_ref/qemu-mips.help                    |  50 ++
 cmdline_ref/qemu-mips64.cpu_help              |  35 ++
 cmdline_ref/qemu-mips64.help                  |  50 ++
 cmdline_ref/qemu-mips64el.cpu_help            |  35 ++
 cmdline_ref/qemu-mips64el.help                |  50 ++
 cmdline_ref/qemu-mipsel.cpu_help              |  19 +
 cmdline_ref/qemu-mipsel.help                  |  50 ++
 cmdline_ref/qemu-mipsn32.cpu_help             |  35 ++
 cmdline_ref/qemu-mipsn32.help                 |  50 ++
 cmdline_ref/qemu-mipsn32el.cpu_help           |  35 ++
 cmdline_ref/qemu-mipsn32el.help               |  50 ++
 cmdline_ref/qemu-or1k.cpu_help                |   3 +
 cmdline_ref/qemu-or1k.help                    |  50 ++
 cmdline_ref/qemu-ppc.cpu_help                 | 432 +++++++++++++
 cmdline_ref/qemu-ppc.help                     |  50 ++
 cmdline_ref/qemu-ppc64.cpu_help               | 464 ++++++++++++++
 cmdline_ref/qemu-ppc64.help                   |  50 ++
 cmdline_ref/qemu-ppc64le.cpu_help             | 464 ++++++++++++++
 cmdline_ref/qemu-ppc64le.help                 |  50 ++
 cmdline_ref/qemu-riscv32.cpu_help             |   9 +
 cmdline_ref/qemu-riscv32.help                 |  50 ++
 cmdline_ref/qemu-riscv64.cpu_help             |  20 +
 cmdline_ref/qemu-riscv64.help                 |  50 ++
 cmdline_ref/qemu-s390x.cpu_help               | 512 +++++++++++++++
 cmdline_ref/qemu-s390x.help                   |  50 ++
 cmdline_ref/qemu-sh4.cpu_help                 |   4 +
 cmdline_ref/qemu-sh4.help                     |  50 ++
 cmdline_ref/qemu-sh4eb.cpu_help               |   4 +
 cmdline_ref/qemu-sh4eb.help                   |  50 ++
 cmdline_ref/qemu-sparc.cpu_help               |  17 +
 cmdline_ref/qemu-sparc.help                   |  50 ++
 cmdline_ref/qemu-sparc32plus.cpu_help         |  21 +
 cmdline_ref/qemu-sparc32plus.help             |  50 ++
 cmdline_ref/qemu-sparc64.cpu_help             |  21 +
 cmdline_ref/qemu-sparc64.help                 |  50 ++
 cmdline_ref/qemu-system-aarch64.cpu_help      |  40 ++
 cmdline_ref/qemu-system-aarch64.device_help   | 446 +++++++++++++
 cmdline_ref/qemu-system-aarch64.help          | 592 +++++++++++++++++
 cmdline_ref/qemu-system-aarch64.machine_help  | 114 ++++
 cmdline_ref/qemu-system-alpha.cpu_help        |   8 +
 cmdline_ref/qemu-system-alpha.device_help     | 243 +++++++
 cmdline_ref/qemu-system-alpha.help            | 555 ++++++++++++++++
 cmdline_ref/qemu-system-alpha.machine_help    |   3 +
 cmdline_ref/qemu-system-arm.cpu_help          |  26 +
 cmdline_ref/qemu-system-arm.device_help       | 442 +++++++++++++
 cmdline_ref/qemu-system-arm.help              | 592 +++++++++++++++++
 cmdline_ref/qemu-system-arm.machine_help      |  96 +++
 cmdline_ref/qemu-system-avr.cpu_help          |   4 +
 cmdline_ref/qemu-system-avr.device_help       |   5 +
 cmdline_ref/qemu-system-avr.help              | 555 ++++++++++++++++
 cmdline_ref/qemu-system-avr.machine_help      |  10 +
 cmdline_ref/qemu-system-hexagon.cpu_help      |  13 +
 cmdline_ref/qemu-system-hexagon.device_help   |  53 ++
 cmdline_ref/qemu-system-hexagon.help          | 555 ++++++++++++++++
 cmdline_ref/qemu-system-hexagon.machine_help  |   4 +
 cmdline_ref/qemu-system-hppa.cpu_help         |   4 +
 cmdline_ref/qemu-system-hppa.device_help      | 238 +++++++
 cmdline_ref/qemu-system-hppa.help             | 555 ++++++++++++++++
 cmdline_ref/qemu-system-hppa.machine_help     |   6 +
 cmdline_ref/qemu-system-i386.cpu_help         | 259 ++++++++
 cmdline_ref/qemu-system-i386.device_help      | 492 +++++++++++++++
 cmdline_ref/qemu-system-i386.help             | 595 ++++++++++++++++++
 cmdline_ref/qemu-system-i386.machine_help     |  42 ++
 cmdline_ref/qemu-system-loongarch64.cpu_help  |   4 +
 .../qemu-system-loongarch64.device_help       | 247 ++++++++
 cmdline_ref/qemu-system-loongarch64.help      | 582 +++++++++++++++++
 .../qemu-system-loongarch64.machine_help      |   5 +
 cmdline_ref/qemu-system-m68k.cpu_help         |  11 +
 cmdline_ref/qemu-system-m68k.device_help      |  59 ++
 cmdline_ref/qemu-system-m68k.help             | 559 ++++++++++++++++
 cmdline_ref/qemu-system-m68k.machine_help     |  25 +
 cmdline_ref/qemu-system-microblaze.cpu_help   |   2 +
 .../qemu-system-microblaze.device_help        | 145 +++++
 cmdline_ref/qemu-system-microblaze.help       | 555 ++++++++++++++++
 .../qemu-system-microblaze.machine_help       |   5 +
 cmdline_ref/qemu-system-mips.cpu_help         |  19 +
 cmdline_ref/qemu-system-mips.device_help      | 244 +++++++
 cmdline_ref/qemu-system-mips.help             | 558 ++++++++++++++++
 cmdline_ref/qemu-system-mips.machine_help     |   3 +
 cmdline_ref/qemu-system-mips64.cpu_help       |  35 ++
 cmdline_ref/qemu-system-mips64.device_help    | 244 +++++++
 cmdline_ref/qemu-system-mips64.help           | 558 ++++++++++++++++
 cmdline_ref/qemu-system-mips64.machine_help   |   5 +
 cmdline_ref/qemu-system-mips64el.cpu_help     |  35 ++
 cmdline_ref/qemu-system-mips64el.device_help  | 262 ++++++++
 cmdline_ref/qemu-system-mips64el.help         | 558 ++++++++++++++++
 cmdline_ref/qemu-system-mips64el.machine_help |   8 +
 cmdline_ref/qemu-system-mipsel.cpu_help       |  19 +
 cmdline_ref/qemu-system-mipsel.device_help    | 244 +++++++
 cmdline_ref/qemu-system-mipsel.help           | 558 ++++++++++++++++
 cmdline_ref/qemu-system-mipsel.machine_help   |   3 +
 cmdline_ref/qemu-system-or1k.cpu_help         |   3 +
 cmdline_ref/qemu-system-or1k.device_help      | 232 +++++++
 cmdline_ref/qemu-system-or1k.help             | 555 ++++++++++++++++
 cmdline_ref/qemu-system-or1k.machine_help     |   4 +
 cmdline_ref/qemu-system-ppc.cpu_help          | 385 ++++++++++++
 cmdline_ref/qemu-system-ppc.device_help       | 271 ++++++++
 cmdline_ref/qemu-system-ppc.help              | 559 ++++++++++++++++
 cmdline_ref/qemu-system-ppc.machine_help      |  14 +
 cmdline_ref/qemu-system-ppc64.cpu_help        | 417 ++++++++++++
 cmdline_ref/qemu-system-ppc64.device_help     | 447 +++++++++++++
 cmdline_ref/qemu-system-ppc64.help            | 559 ++++++++++++++++
 cmdline_ref/qemu-system-ppc64.machine_help    |  39 ++
 cmdline_ref/qemu-system-riscv32.cpu_help      |   9 +
 cmdline_ref/qemu-system-riscv32.device_help   | 385 ++++++++++++
 cmdline_ref/qemu-system-riscv32.help          | 586 +++++++++++++++++
 cmdline_ref/qemu-system-riscv32.machine_help  |   8 +
 cmdline_ref/qemu-system-riscv64.cpu_help      |  29 +
 cmdline_ref/qemu-system-riscv64.device_help   | 388 ++++++++++++
 cmdline_ref/qemu-system-riscv64.help          | 586 +++++++++++++++++
 cmdline_ref/qemu-system-riscv64.machine_help  |  13 +
 cmdline_ref/qemu-system-rx.cpu_help           |   2 +
 cmdline_ref/qemu-system-rx.device_help        |  10 +
 cmdline_ref/qemu-system-rx.help               | 555 ++++++++++++++++
 cmdline_ref/qemu-system-rx.machine_help       |   4 +
 cmdline_ref/qemu-system-s390x.cpu_help        | 512 +++++++++++++++
 cmdline_ref/qemu-system-s390x.device_help     | 257 ++++++++
 cmdline_ref/qemu-system-s390x.help            | 556 ++++++++++++++++
 cmdline_ref/qemu-system-s390x.machine_help    |  21 +
 cmdline_ref/qemu-system-sh4.cpu_help          |   4 +
 cmdline_ref/qemu-system-sh4.device_help       | 240 +++++++
 cmdline_ref/qemu-system-sh4.help              | 555 ++++++++++++++++
 cmdline_ref/qemu-system-sh4.machine_help      |   3 +
 cmdline_ref/qemu-system-sh4eb.cpu_help        |   4 +
 cmdline_ref/qemu-system-sh4eb.device_help     | 240 +++++++
 cmdline_ref/qemu-system-sh4eb.help            | 555 ++++++++++++++++
 cmdline_ref/qemu-system-sh4eb.machine_help    |   3 +
 cmdline_ref/qemu-system-sparc.cpu_help        |  17 +
 cmdline_ref/qemu-system-sparc.device_help     |  12 +
 cmdline_ref/qemu-system-sparc.help            | 558 ++++++++++++++++
 cmdline_ref/qemu-system-sparc.machine_help    |  12 +
 cmdline_ref/qemu-system-sparc64.cpu_help      |  21 +
 cmdline_ref/qemu-system-sparc64.device_help   | 244 +++++++
 cmdline_ref/qemu-system-sparc64.help          | 558 ++++++++++++++++
 cmdline_ref/qemu-system-sparc64.machine_help  |   5 +
 cmdline_ref/qemu-system-tricore.cpu_help      |   5 +
 cmdline_ref/qemu-system-tricore.device_help   |   5 +
 cmdline_ref/qemu-system-tricore.help          | 555 ++++++++++++++++
 cmdline_ref/qemu-system-tricore.machine_help  |   4 +
 cmdline_ref/qemu-system-x86_64.cpu_help       | 259 ++++++++
 cmdline_ref/qemu-system-x86_64.device_help    | 492 +++++++++++++++
 cmdline_ref/qemu-system-x86_64.help           | 595 ++++++++++++++++++
 cmdline_ref/qemu-system-x86_64.machine_help   |  42 ++
 cmdline_ref/qemu-system-xtensa.cpu_help       |   9 +
 cmdline_ref/qemu-system-xtensa.device_help    | 226 +++++++
 cmdline_ref/qemu-system-xtensa.help           | 558 ++++++++++++++++
 cmdline_ref/qemu-system-xtensa.machine_help   |  12 +
 cmdline_ref/qemu-system-xtensaeb.cpu_help     |   3 +
 cmdline_ref/qemu-system-xtensaeb.device_help  | 226 +++++++
 cmdline_ref/qemu-system-xtensaeb.help         | 558 ++++++++++++++++
 cmdline_ref/qemu-system-xtensaeb.machine_help |  12 +
 cmdline_ref/qemu-x86_64.cpu_help              | 259 ++++++++
 cmdline_ref/qemu-x86_64.help                  |  50 ++
 cmdline_ref/qemu-xtensa.cpu_help              |   9 +
 cmdline_ref/qemu-xtensa.help                  |  51 ++
 cmdline_ref/qemu-xtensaeb.cpu_help            |   3 +
 cmdline_ref/qemu-xtensaeb.help                |  51 ++
 cmdline_update_ref.sh                         |  49 ++
 configs/targets/aarch64-softmmu.c             |  27 -
 configs/targets/arm-softmmu.c                 |  27 -
 configs/targets/meson.build                   |   6 -
 configs/targets/riscv32-softmmu.c             |  26 -
 configs/targets/riscv64-softmmu.c             |  26 -
 docs/system/arm/emulation.rst                 |  13 +-
 hw/alpha/dp264.c                              |   2 +-
 hw/arm/aspeed.c                               |   1 -
 hw/arm/aspeed_ast1040_evb.c                   |   3 +-
 hw/arm/aspeed_ast10x0_evb.c                   |   5 +-
 hw/arm/aspeed_ast2400_palmetto.c              |   3 +-
 hw/arm/aspeed_ast2400_quanta-q71l.c           |   3 +-
 hw/arm/aspeed_ast2400_supermicrox11.c         |   3 +-
 hw/arm/aspeed_ast2500_evb.c                   |   3 +-
 hw/arm/aspeed_ast2500_g220a.c                 |   3 +-
 hw/arm/aspeed_ast2500_romulus.c               |   3 +-
 hw/arm/aspeed_ast2500_supermicro-x11spi.c     |   3 +-
 hw/arm/aspeed_ast2500_tiogapass.c             |   3 +-
 hw/arm/aspeed_ast2500_witherspoon.c           |   3 +-
 hw/arm/aspeed_ast2500_yosemitev2.c            |   3 +-
 hw/arm/aspeed_ast2600_anacapa.c               |   3 +-
 hw/arm/aspeed_ast2600_bletchley.c             |   3 +-
 hw/arm/aspeed_ast2600_catalina.c              |   3 +-
 hw/arm/aspeed_ast2600_evb.c                   |   3 +-
 hw/arm/aspeed_ast2600_fby35.c                 |   3 +-
 hw/arm/aspeed_ast2600_fuji.c                  |   3 +-
 hw/arm/aspeed_ast2600_gb200nvl.c              |   3 +-
 hw/arm/aspeed_ast2600_rainier.c               |   3 +-
 hw/arm/aspeed_ast27x0-fc.c                    |   3 +-
 hw/arm/aspeed_ast27x0_evb.c                   |   5 +-
 hw/arm/ax3000-boards.c                        |   2 -
 hw/arm/ax3000-evk.c                           |   1 +
 hw/arm/b-l475e-iot01a.c                       |   3 +-
 hw/arm/bananapi_m2u.c                         |   3 +-
 hw/arm/collie.c                               |   3 +-
 hw/arm/cubieboard.c                           |   3 +-
 hw/arm/digic_boards.c                         |   3 +-
 hw/arm/exynos4_boards.c                       |   5 +-
 hw/arm/imx25_pdk.c                            |   3 +-
 hw/arm/imx8mm-evk.c                           |  19 +-
 hw/arm/imx8mp-evk.c                           |   3 +-
 hw/arm/integratorcp.c                         |   3 +-
 hw/arm/kzm.c                                  |   3 +-
 hw/arm/max78000fthr.c                         |   3 +-
 hw/arm/mcimx6ul-evk.c                         |   3 +-
 hw/arm/mcimx7d-sabre.c                        |   3 +-
 hw/arm/microbit.c                             |   3 +-
 hw/arm/mps2-tz.c                              |   9 +-
 hw/arm/mps2.c                                 |   9 +-
 hw/arm/mps3r.c                                |   3 +-
 hw/arm/msf2-som.c                             |   3 +-
 hw/arm/musca.c                                |   5 +-
 hw/arm/musicpal.c                             |   3 +-
 hw/arm/netduino2.c                            |   3 +-
 hw/arm/netduinoplus2.c                        |   3 +-
 hw/arm/npcm7xx_boards.c                       |  11 +-
 hw/arm/npcm8xx_boards.c                       |   3 +-
 hw/arm/olimex-stm32-h405.c                    |   4 +-
 hw/arm/omap_sx1.c                             |   5 +-
 hw/arm/orangepi.c                             |   3 +-
 hw/arm/raspi.c                                |  11 +-
 hw/arm/raspi4b.c                              |   3 +-
 hw/arm/realview.c                             |   9 +-
 hw/arm/sabrelite.c                            |   3 +-
 hw/arm/sbsa-ref.c                             |   5 +-
 hw/arm/stellaris.c                            |   5 +-
 hw/arm/stm32vldiscovery.c                     |   4 +-
 hw/arm/versatilepb.c                          |   5 +-
 hw/arm/vexpress.c                             |   5 +-
 hw/arm/virt.c                                 |   5 +-
 hw/arm/xen-pvh.c                              |   2 -
 hw/arm/xilinx_zynq.c                          |   3 +-
 hw/arm/xlnx-versal-virt.c                     |   5 +-
 hw/arm/xlnx-zcu102.c                          |   3 +-
 hw/core/machine-qmp-cmds.c                    |   2 +-
 hw/core/null-machine.c                        |   9 +-
 hw/display/dpcd.c                             |   1 +
 hw/m68k/an5206.c                              |   2 +-
 hw/m68k/mcf5208.c                             |   2 +-
 hw/microblaze/petalogix_ml605_mmu.c           |   3 +-
 hw/microblaze/petalogix_s3adsp1800_mmu.c      |   1 +
 hw/microblaze/xlnx-zynqmp-pmu.c               |   3 +-
 hw/mips/boston.c                              |   2 +-
 hw/mips/fuloong2e.c                           |   2 +-
 hw/mips/malta.c                               |   2 +-
 hw/nitro/heartbeat.c                          |   1 +
 hw/nitro/machine.c                            |   7 +-
 hw/nitro/serial-vsock.c                       |   1 +
 hw/pci-bridge/cxl_downstream.c                |   1 +
 hw/pci-bridge/cxl_root_port.c                 |   1 +
 hw/pci-bridge/cxl_upstream.c                  |   1 +
 hw/pci-host/aspeed_pcie.c                     |   1 +
 hw/ppc/amigaone.c                             |   2 +-
 hw/ppc/pegasos.c                              |   2 +-
 hw/ppc/ppc440_bamboo.c                        |   2 +-
 hw/ppc/prep.c                                 |   2 +-
 hw/ppc/sam460ex.c                             |   2 +-
 hw/ppc/virtex_ml507.c                         |   2 +-
 hw/remote/machine.c                           |   4 +-
 hw/remote/proxy.c                             |   1 +
 hw/riscv/boston-aia.c                         |   3 +-
 hw/riscv/k230.c                               |   2 -
 hw/riscv/microblaze-v-generic.c               |   3 +-
 hw/riscv/microchip_pfsoc.c                    |   2 -
 hw/riscv/opentitan.c                          |   2 -
 hw/riscv/shakti_c.c                           |   2 -
 hw/riscv/sifive_e.c                           |   2 -
 hw/riscv/sifive_u.c                           |   2 -
 hw/riscv/spike.c                              |   2 -
 hw/riscv/tt_atlantis.c                        |   2 -
 hw/riscv/virt.c                               |   3 -
 hw/riscv/xiangshan_kmh.c                      |   2 -
 hw/sh4/r2d.c                                  |   2 +-
 hw/sparc/leon3.c                              |   2 +-
 hw/tricore/tricore_testboard.c                |   2 +-
 hw/xenpv/xen_machine_pv.c                     |   2 +-
 hw/xtensa/sim.c                               |   2 +-
 hw/xtensa/virt.c                              |   2 +-
 include/hw/arm/machines-qom.h                 |  46 --
 include/hw/core/boards.h                      |  16 +-
 include/hw/riscv/machines-qom.h               |  46 --
 include/qemu/target-info-impl.h               |  11 +-
 include/qemu/target-info-qom.h                |   2 +
 include/qemu/target-info.h                    |  43 +-
 include/qom/object.h                          |   3 +
 meson.build                                   |  53 +-
 monitor/qemu-config-qmp.c                     |   2 +-
 qemu-options.hx                               |   8 +
 qom/object.c                                  |   4 +
 rust/qom/src/qom.rs                           |   1 +
 scripts/single-binary-compare-cmdline.sh      |  51 ++
 system/vl.c                                   |  39 +-
 target-info-stub.c => target-info-def.c       |  17 +-
 target-info-qom.c                             | 117 +++-
 target-info.c                                 |  31 +-
 target/arm/cpu-max.c                          |   6 +-
 target/arm/cpu.c                              |   3 +-
 target/arm/cpu64.c                            |   2 +-
 target/arm/internals.h                        |   7 +-
 target/arm/machine.c                          |  18 -
 target/arm/tcg/cpu-max-v8.c                   | 130 ++++
 target/arm/tcg/cpu-v7m.c                      |   2 +-
 target/arm/tcg/cpu32.c                        | 118 +---
 target/arm/tcg/cpu64.c                        | 161 +++--
 target/arm/tcg/meson.build                    |  11 +-
 target/arm/tcg/stubs32.c                      |   7 +-
 target/microblaze/cpu.c                       |   1 +
 target/riscv/machine.c                        |  17 -
 .../aarch64/test_virt_aarch64_off.py          |   4 +-
 tests/qtest/arm-cpu-features.c                |   4 +-
 tests/qtest/fuzz/fuzz.c                       |   2 +-
 334 files changed, 31366 insertions(+), 716 deletions(-)
 create mode 100644 cmdline_ref/qemu-aarch64.cpu_help
 create mode 100644 cmdline_ref/qemu-aarch64.help
 create mode 100644 cmdline_ref/qemu-aarch64_be.cpu_help
 create mode 100644 cmdline_ref/qemu-aarch64_be.help
 create mode 100644 cmdline_ref/qemu-alpha.cpu_help
 create mode 100644 cmdline_ref/qemu-alpha.help
 create mode 100644 cmdline_ref/qemu-arm.cpu_help
 create mode 100644 cmdline_ref/qemu-arm.help
 create mode 100644 cmdline_ref/qemu-armeb.cpu_help
 create mode 100644 cmdline_ref/qemu-armeb.help
 create mode 100644 cmdline_ref/qemu-hexagon.cpu_help
 create mode 100644 cmdline_ref/qemu-hexagon.help
 create mode 100644 cmdline_ref/qemu-hppa.cpu_help
 create mode 100644 cmdline_ref/qemu-hppa.help
 create mode 100644 cmdline_ref/qemu-i386.cpu_help
 create mode 100644 cmdline_ref/qemu-i386.help
 create mode 100644 cmdline_ref/qemu-loongarch64.cpu_help
 create mode 100644 cmdline_ref/qemu-loongarch64.help
 create mode 100644 cmdline_ref/qemu-m68k.cpu_help
 create mode 100644 cmdline_ref/qemu-m68k.help
 create mode 100644 cmdline_ref/qemu-microblaze.cpu_help
 create mode 100644 cmdline_ref/qemu-microblaze.help
 create mode 100644 cmdline_ref/qemu-microblazeel.cpu_help
 create mode 100644 cmdline_ref/qemu-microblazeel.help
 create mode 100644 cmdline_ref/qemu-mips.cpu_help
 create mode 100644 cmdline_ref/qemu-mips.help
 create mode 100644 cmdline_ref/qemu-mips64.cpu_help
 create mode 100644 cmdline_ref/qemu-mips64.help
 create mode 100644 cmdline_ref/qemu-mips64el.cpu_help
 create mode 100644 cmdline_ref/qemu-mips64el.help
 create mode 100644 cmdline_ref/qemu-mipsel.cpu_help
 create mode 100644 cmdline_ref/qemu-mipsel.help
 create mode 100644 cmdline_ref/qemu-mipsn32.cpu_help
 create mode 100644 cmdline_ref/qemu-mipsn32.help
 create mode 100644 cmdline_ref/qemu-mipsn32el.cpu_help
 create mode 100644 cmdline_ref/qemu-mipsn32el.help
 create mode 100644 cmdline_ref/qemu-or1k.cpu_help
 create mode 100644 cmdline_ref/qemu-or1k.help
 create mode 100644 cmdline_ref/qemu-ppc.cpu_help
 create mode 100644 cmdline_ref/qemu-ppc.help
 create mode 100644 cmdline_ref/qemu-ppc64.cpu_help
 create mode 100644 cmdline_ref/qemu-ppc64.help
 create mode 100644 cmdline_ref/qemu-ppc64le.cpu_help
 create mode 100644 cmdline_ref/qemu-ppc64le.help
 create mode 100644 cmdline_ref/qemu-riscv32.cpu_help
 create mode 100644 cmdline_ref/qemu-riscv32.help
 create mode 100644 cmdline_ref/qemu-riscv64.cpu_help
 create mode 100644 cmdline_ref/qemu-riscv64.help
 create mode 100644 cmdline_ref/qemu-s390x.cpu_help
 create mode 100644 cmdline_ref/qemu-s390x.help
 create mode 100644 cmdline_ref/qemu-sh4.cpu_help
 create mode 100644 cmdline_ref/qemu-sh4.help
 create mode 100644 cmdline_ref/qemu-sh4eb.cpu_help
 create mode 100644 cmdline_ref/qemu-sh4eb.help
 create mode 100644 cmdline_ref/qemu-sparc.cpu_help
 create mode 100644 cmdline_ref/qemu-sparc.help
 create mode 100644 cmdline_ref/qemu-sparc32plus.cpu_help
 create mode 100644 cmdline_ref/qemu-sparc32plus.help
 create mode 100644 cmdline_ref/qemu-sparc64.cpu_help
 create mode 100644 cmdline_ref/qemu-sparc64.help
 create mode 100644 cmdline_ref/qemu-system-aarch64.cpu_help
 create mode 100644 cmdline_ref/qemu-system-aarch64.device_help
 create mode 100644 cmdline_ref/qemu-system-aarch64.help
 create mode 100644 cmdline_ref/qemu-system-aarch64.machine_help
 create mode 100644 cmdline_ref/qemu-system-alpha.cpu_help
 create mode 100644 cmdline_ref/qemu-system-alpha.device_help
 create mode 100644 cmdline_ref/qemu-system-alpha.help
 create mode 100644 cmdline_ref/qemu-system-alpha.machine_help
 create mode 100644 cmdline_ref/qemu-system-arm.cpu_help
 create mode 100644 cmdline_ref/qemu-system-arm.device_help
 create mode 100644 cmdline_ref/qemu-system-arm.help
 create mode 100644 cmdline_ref/qemu-system-arm.machine_help
 create mode 100644 cmdline_ref/qemu-system-avr.cpu_help
 create mode 100644 cmdline_ref/qemu-system-avr.device_help
 create mode 100644 cmdline_ref/qemu-system-avr.help
 create mode 100644 cmdline_ref/qemu-system-avr.machine_help
 create mode 100644 cmdline_ref/qemu-system-hexagon.cpu_help
 create mode 100644 cmdline_ref/qemu-system-hexagon.device_help
 create mode 100644 cmdline_ref/qemu-system-hexagon.help
 create mode 100644 cmdline_ref/qemu-system-hexagon.machine_help
 create mode 100644 cmdline_ref/qemu-system-hppa.cpu_help
 create mode 100644 cmdline_ref/qemu-system-hppa.device_help
 create mode 100644 cmdline_ref/qemu-system-hppa.help
 create mode 100644 cmdline_ref/qemu-system-hppa.machine_help
 create mode 100644 cmdline_ref/qemu-system-i386.cpu_help
 create mode 100644 cmdline_ref/qemu-system-i386.device_help
 create mode 100644 cmdline_ref/qemu-system-i386.help
 create mode 100644 cmdline_ref/qemu-system-i386.machine_help
 create mode 100644 cmdline_ref/qemu-system-loongarch64.cpu_help
 create mode 100644 cmdline_ref/qemu-system-loongarch64.device_help
 create mode 100644 cmdline_ref/qemu-system-loongarch64.help
 create mode 100644 cmdline_ref/qemu-system-loongarch64.machine_help
 create mode 100644 cmdline_ref/qemu-system-m68k.cpu_help
 create mode 100644 cmdline_ref/qemu-system-m68k.device_help
 create mode 100644 cmdline_ref/qemu-system-m68k.help
 create mode 100644 cmdline_ref/qemu-system-m68k.machine_help
 create mode 100644 cmdline_ref/qemu-system-microblaze.cpu_help
 create mode 100644 cmdline_ref/qemu-system-microblaze.device_help
 create mode 100644 cmdline_ref/qemu-system-microblaze.help
 create mode 100644 cmdline_ref/qemu-system-microblaze.machine_help
 create mode 100644 cmdline_ref/qemu-system-mips.cpu_help
 create mode 100644 cmdline_ref/qemu-system-mips.device_help
 create mode 100644 cmdline_ref/qemu-system-mips.help
 create mode 100644 cmdline_ref/qemu-system-mips.machine_help
 create mode 100644 cmdline_ref/qemu-system-mips64.cpu_help
 create mode 100644 cmdline_ref/qemu-system-mips64.device_help
 create mode 100644 cmdline_ref/qemu-system-mips64.help
 create mode 100644 cmdline_ref/qemu-system-mips64.machine_help
 create mode 100644 cmdline_ref/qemu-system-mips64el.cpu_help
 create mode 100644 cmdline_ref/qemu-system-mips64el.device_help
 create mode 100644 cmdline_ref/qemu-system-mips64el.help
 create mode 100644 cmdline_ref/qemu-system-mips64el.machine_help
 create mode 100644 cmdline_ref/qemu-system-mipsel.cpu_help
 create mode 100644 cmdline_ref/qemu-system-mipsel.device_help
 create mode 100644 cmdline_ref/qemu-system-mipsel.help
 create mode 100644 cmdline_ref/qemu-system-mipsel.machine_help
 create mode 100644 cmdline_ref/qemu-system-or1k.cpu_help
 create mode 100644 cmdline_ref/qemu-system-or1k.device_help
 create mode 100644 cmdline_ref/qemu-system-or1k.help
 create mode 100644 cmdline_ref/qemu-system-or1k.machine_help
 create mode 100644 cmdline_ref/qemu-system-ppc.cpu_help
 create mode 100644 cmdline_ref/qemu-system-ppc.device_help
 create mode 100644 cmdline_ref/qemu-system-ppc.help
 create mode 100644 cmdline_ref/qemu-system-ppc.machine_help
 create mode 100644 cmdline_ref/qemu-system-ppc64.cpu_help
 create mode 100644 cmdline_ref/qemu-system-ppc64.device_help
 create mode 100644 cmdline_ref/qemu-system-ppc64.help
 create mode 100644 cmdline_ref/qemu-system-ppc64.machine_help
 create mode 100644 cmdline_ref/qemu-system-riscv32.cpu_help
 create mode 100644 cmdline_ref/qemu-system-riscv32.device_help
 create mode 100644 cmdline_ref/qemu-system-riscv32.help
 create mode 100644 cmdline_ref/qemu-system-riscv32.machine_help
 create mode 100644 cmdline_ref/qemu-system-riscv64.cpu_help
 create mode 100644 cmdline_ref/qemu-system-riscv64.device_help
 create mode 100644 cmdline_ref/qemu-system-riscv64.help
 create mode 100644 cmdline_ref/qemu-system-riscv64.machine_help
 create mode 100644 cmdline_ref/qemu-system-rx.cpu_help
 create mode 100644 cmdline_ref/qemu-system-rx.device_help
 create mode 100644 cmdline_ref/qemu-system-rx.help
 create mode 100644 cmdline_ref/qemu-system-rx.machine_help
 create mode 100644 cmdline_ref/qemu-system-s390x.cpu_help
 create mode 100644 cmdline_ref/qemu-system-s390x.device_help
 create mode 100644 cmdline_ref/qemu-system-s390x.help
 create mode 100644 cmdline_ref/qemu-system-s390x.machine_help
 create mode 100644 cmdline_ref/qemu-system-sh4.cpu_help
 create mode 100644 cmdline_ref/qemu-system-sh4.device_help
 create mode 100644 cmdline_ref/qemu-system-sh4.help
 create mode 100644 cmdline_ref/qemu-system-sh4.machine_help
 create mode 100644 cmdline_ref/qemu-system-sh4eb.cpu_help
 create mode 100644 cmdline_ref/qemu-system-sh4eb.device_help
 create mode 100644 cmdline_ref/qemu-system-sh4eb.help
 create mode 100644 cmdline_ref/qemu-system-sh4eb.machine_help
 create mode 100644 cmdline_ref/qemu-system-sparc.cpu_help
 create mode 100644 cmdline_ref/qemu-system-sparc.device_help
 create mode 100644 cmdline_ref/qemu-system-sparc.help
 create mode 100644 cmdline_ref/qemu-system-sparc.machine_help
 create mode 100644 cmdline_ref/qemu-system-sparc64.cpu_help
 create mode 100644 cmdline_ref/qemu-system-sparc64.device_help
 create mode 100644 cmdline_ref/qemu-system-sparc64.help
 create mode 100644 cmdline_ref/qemu-system-sparc64.machine_help
 create mode 100644 cmdline_ref/qemu-system-tricore.cpu_help
 create mode 100644 cmdline_ref/qemu-system-tricore.device_help
 create mode 100644 cmdline_ref/qemu-system-tricore.help
 create mode 100644 cmdline_ref/qemu-system-tricore.machine_help
 create mode 100644 cmdline_ref/qemu-system-x86_64.cpu_help
 create mode 100644 cmdline_ref/qemu-system-x86_64.device_help
 create mode 100644 cmdline_ref/qemu-system-x86_64.help
 create mode 100644 cmdline_ref/qemu-system-x86_64.machine_help
 create mode 100644 cmdline_ref/qemu-system-xtensa.cpu_help
 create mode 100644 cmdline_ref/qemu-system-xtensa.device_help
 create mode 100644 cmdline_ref/qemu-system-xtensa.help
 create mode 100644 cmdline_ref/qemu-system-xtensa.machine_help
 create mode 100644 cmdline_ref/qemu-system-xtensaeb.cpu_help
 create mode 100644 cmdline_ref/qemu-system-xtensaeb.device_help
 create mode 100644 cmdline_ref/qemu-system-xtensaeb.help
 create mode 100644 cmdline_ref/qemu-system-xtensaeb.machine_help
 create mode 100644 cmdline_ref/qemu-x86_64.cpu_help
 create mode 100644 cmdline_ref/qemu-x86_64.help
 create mode 100644 cmdline_ref/qemu-xtensa.cpu_help
 create mode 100644 cmdline_ref/qemu-xtensa.help
 create mode 100644 cmdline_ref/qemu-xtensaeb.cpu_help
 create mode 100644 cmdline_ref/qemu-xtensaeb.help
 create mode 100755 cmdline_update_ref.sh
 delete mode 100644 configs/targets/aarch64-softmmu.c
 delete mode 100644 configs/targets/arm-softmmu.c
 delete mode 100644 configs/targets/meson.build
 delete mode 100644 configs/targets/riscv32-softmmu.c
 delete mode 100644 configs/targets/riscv64-softmmu.c
 delete mode 100644 include/hw/arm/machines-qom.h
 delete mode 100644 include/hw/riscv/machines-qom.h
 create mode 100755 scripts/single-binary-compare-cmdline.sh
 rename target-info-stub.c => target-info-def.c (81%)
 create mode 100644 target/arm/tcg/cpu-max-v8.c

-- 
2.43.0


