Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5689B606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 06:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=okQFzeEt;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=i7FizgOb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR1Sy-000146-Q3; Wed, 11 Nov 2026 01:05:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xR1Sn-0000bB-OB
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 01:05:42 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xR1Sl-0000pr-Or
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 01:05:41 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AB5KK3S1343642
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 06:05:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=j2wyj8OuvvQHC6RZZdC0zyewFLN+ddlJWA1
 AJXWe7p0=; b=okQFzeEt95zLTuAp1UXMu//+H7PRTDnpmLC5mIeD/ICI+qRV8EQ
 5dMFoBpfB8yJppJ9hwX+A0jlXtZDPXXKwNMpGKu32gW8BGafT1OxNUUX0XBuSMun
 A0dgNR2eIu6bs7hkQhYHVs0N1QLdfhddesnr2s89TxVOrB9Gi4v0SksW0LmfDVlo
 FvikbnQi8dGaPk4ecy2hcx8jL2kb3se9H2KPm0NMGxcXYLNIaK0eZ3KqgIZsl3Xe
 OSqwxio6neLmFeUFecU3cMZu/x2MChMNkV9DrKnyKPwyMYfOfwvFju/b5iKY7Vmu
 uDGbtidcixqPfOAlXVsJdo/5rVRaIeDe5Kw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huyufvjy3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 06:05:36 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36f9bc93925so31080eec.1
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 22:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794377136; x=1794981936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=j2wyj8OuvvQHC6RZZdC0zyewFLN+ddlJWA1AJXWe7p0=;
 b=i7FizgObR7JoCAMb/c38u+WkUfZ7ol4/QAfzjUbLPtXtc69YGQdSD/56vUOEFkBq3l
 Sc2boup8FGNWJJmUM8ZuG842ZoFQTK7lfjufk+bMjMPxPHidFeHixDtq4WJN7qQGs3/0
 +LDvjO86WY7EHu7Tx0Kv7p0Rg2DxNMOYV2VP079PbIqdjFe012TR4XFeCniwAQQU19pM
 5fpz0VJK/RSofPXDJCdM7d12Iy2yt2BWhljzzzFl+JtaRVggblZuJL7bTf/6pqA6A1uw
 WdQFCP3NBiKnMzmNGOJdIeufH3Me4EYTWvcKaXLrAbzsFfWRZ22FehbTYf37E84cph6D
 s/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794377136; x=1794981936;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j2wyj8OuvvQHC6RZZdC0zyewFLN+ddlJWA1AJXWe7p0=;
 b=rvmD1f5/68YZMrate0grCMSnHN66kUXMpDVZF2+wf9D7uy4MvP3JGo2R2U/r6bC+hn
 FZ16i6U33yPL0puglUBAmmDoN2HWUlN9mZ1L+m82YHhot1XH+CF+4qDbnvFOmgTO4YEA
 51+TyS8g176gR5keMNxCvBjcT8Pj7dOn6CoMyMd2n0qL33mh3RMX/XNKNWTa7RSvo2FB
 W6encNRjw4mgVWjhKrOh9ciQde0FPBpK5wwP8ek2RuRVcGyKAed5n/Z91NFrFtLs9qpN
 6iN82op2oULJPNc0lt7ZPYh/y8xa0NkvuQqtQB6KmQZ7zLW2O8Eg6aysCbFqzGpI70Vn
 NziQ==
X-Gm-Message-State: APuU4Z8/0Sc7vPAhamKQpE5upGCUu6P7KtZ84W8riPPtVcPu2ecb21FJ
 cf8+UY2nXSSk17QpVkRd8neyvyyhVtEJNosNPqxxE9fS0HlKm+ILCOlXrojVxxz4Ls4IhP++u2w
 tmsNhP0Bl9lloL7yQuTPhvULGtTJm2tlhKFTGkiZv5qEbNwO4zxpfZ2seCJBnHbZdfQ==
X-Gm-Gg: AYBFou10VNX+IIc+SyqGnxtZzxFxyH+cRq05TcmozZkt2RndujyjyGLw2N5F/QO9tMy
 jFb+ZAp4ix8MKe6NBN7JVMTXw5mGxr14Ebnr/YrJkfBHFU2uGHkyzitzZGQ/bSMplLV7hikWBy6
 vsN4PFW9Q0vo1kE6nAUpZ1DZ3P12v8vZVdIevu/Ge9TlWA8Y5zhLZR1YhuqHZwO0e4qVHOqYVaH
 ebhshniZm4YDPkyBEDQPC/ZGEre6lobvlXEFmp/WzFHXs1oI0ctBscyj9lsBfBoef14d/HEIWWq
 mPm/6LuECd6RDsVWwftb/LKeTVjKDZ+sEQDhF+/BwT6vdVL8Mx01KAPi5/TPeU7VlkrSxdrZ0di
 k6iOwB0eBS6PVTKboVi4U7JG1m+Ze/jKIBBNKF5UITcHoC9FBLc6NibhpgKkRZ1Pv4NP3vUw6T4
 mGW5EJl4HcuP5Z69KtqvdV99ZK08dqOOeYzrYOGLjhNqcdncc3qnwySIK2r6zipeWdBOYtb9Jz0
 zKvYaU=
X-Received: by 2002:a05:701b:42c7:20b0:1b2:5884:a039 with SMTP id
 a92af1059eb24-1b3c0151554mr2458745c88.0.1794377135602; 
 Tue, 10 Nov 2026 22:05:35 -0800 (PST)
X-Received: by 2002:a05:701b:42c7:20b0:1b2:5884:a039 with SMTP id
 a92af1059eb24-1b3c0151554mr2458683c88.0.1794377134879; 
 Tue, 10 Nov 2026 22:05:34 -0800 (PST)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b3b5890c0esm12674313c88.1.2026.11.10.22.05.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 22:05:34 -0800 (PST)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Charles Perry <charles.perry@microchip.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Philippe Mathieu-Daude <philmd@oss.qualcomm.com>,
 Sunil V L <sunilvl@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, marcandre.lureau@redhat.com,
 berrange@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v5 0/2] hw/riscv: add RPMI support for server reference
 platform
Date: Wed, 11 Nov 2026 11:35:21 +0530
Message-ID: <20261111060523.3779325-1-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8_l6BaM40Z0lZHXBKcpVhCvpBiBzt1li
X-Authority-Analysis: v=2.4 cv=S6lMU4sP c=1 sm=1 tr=0 ts=6af405b0 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=Ssm4dOjzjMnu0MGFRxsA:9
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: 8_l6BaM40Z0lZHXBKcpVhCvpBiBzt1li
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAyNCBTYWx0ZWRfX+dVgZaZxPK0J
 qrm39RFzqzm98GxFipKsg6p1Plg90FCWeN21DF+moT0u4XVRdW7nVFwMc9kCRkvMCdc03QnDG6A
 g3uA3pgNP3uL5unR202hJKAjbOgp/KM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAyNCBTYWx0ZWRfX559lvOS5YHqu
 ANnptsNYDxX4ylLu5H/7OAxDywqVOSxSrfzBPkYptPBJkoZApbXNQub08QbFujAXox1gKS4ksCZ
 Lv8X9OZ8djVbkukgPcuAM+An/yqWxaNEGQTvVO8my6LxD2yeH7GWHTVYUe3e8W6hzESxvrsL8JX
 qnK7rEQoC+GJL+2I7lb+/cGEmspwLMzcdlzTRZ2s3u2nnpdytIURwKdClet/SmmeMoYjU94jsps
 +Fm2hXhjBgvLhVhU+rub0wH1QvrNgdskptPoeQ+2A4aNPMFQ80UzcS593iOVB2kR56ykzCSbOUW
 tAAKInT+6YwJTZNxGklVHEOKFjz9iYAEnG5aiCrjJbJfM5EQKinRXDx+z5ttW5TCR2ZZn//hBvW
 nDP8Vi3fSrnn86PuxKb4nxyRExgD7dOHKcLmSwJeYuNJmT7fXSA1ixIQbrM8QLCKQ1X4Pn/deS1
 fuZJsa+NcuYqTQgiDog==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110024
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add RPMI transport and service-group support to the RISC-V Server Platform
Reference Board. The series applies on top of the initial RPMI virt support
series and wires the board's reset, HSM, and system-suspend operations to the
same librpmi-backed implementation used by ``virt``.

The RPMI FDT service nodes are emitted as ``/soc/<service>`` siblings of the
shared-memory mailbox. Each node keeps its ``mboxes`` phandle and
service-group ID, and the server-reference qtest checks this hierarchy as a
regression.

Dependencies:
- [PATCH v15 00/10] riscv: add initial RPMI virt support.
- The server-reference board is already present in QEMU master at
  74f7bf4c59e6b6d50dbc6e124d93440be8be4386.

Changes since v4:
- Rebase onto the updated initial RPMI v15 prerequisite; server-reference
  code is unchanged. Wrap one long assertion in the qtest.

Changes since v3:
- Rebase onto QEMU master and the initial RPMI v14 prerequisite.
- Keep the board integration and its queue sizes unchanged.
- [2/2] tests/qtest: cover server reference platform RPMI:
  - Use per-machine queue sizes in the shared harness: virt uses
    30 KiB queues while server-reference retains 1 KiB queues.
    Derive acknowledgement offsets and ring moduli accordingly.
  - Inherit resume-address coverage for RAM-backed PCs, MMIO and
    unmapped rejection, and RV32 width checks on mapped high RAM.

Changes since v2:
- Rebase the server-reference integration onto QEMU master and the v13 RPMI
  virt prerequisite.
- [1/2] hw/riscv: add RPMI support for server reference platform:
  - Add an explicit ``rpmi=on|off`` property, defaulting to off so the
    existing board remains migratable and retains its legacy reset/poweroff
    device-tree nodes.
  - Gate RPMI realization, reset/shutdown callbacks, and service nodes on the
    property; reject explicit enablement for KVM and no-librpmi builds.
  - Document the property, migration restriction, build requirements, and
    both device-tree layouts.
- [2/2] tests/qtest: cover server reference platform RPMI:
  - Reuse the common RPMI protocol tests and register the server-reference
    machine-specific subset.
  - Add checks for default/off and explicit-on machine policy,
    service-node sibling placement, mailbox phandles and service IDs,
    legacy syscon nodes, and migration behavior.
  - Name the RPMI-off migration test as a policy-command acceptance check;
    it does not restore a destination VM.

Testing:
- Combined RPMI-enabled RISC-V build: passed.
- RPMI/server-reference qtests: 30/30 subtests passed.
- Server-reference guest boots were not rerun on the updated v15 base.

Subrahmanya Lingappa (2):
  hw/riscv: add RPMI support for server reference platform
  tests/qtest: cover server reference platform RPMI

 docs/system/riscv/riscv-server-ref.rst |  43 ++++
 hw/riscv/Kconfig                       |   1 +
 hw/riscv/server_platform_ref.c         | 149 ++++++++++-
 meson.build                            |   4 +
 tests/qtest/riscv-rpmi-test.c          | 435 +++++++++++++++++++++++++--------
 5 files changed, 532 insertions(+), 100 deletions(-)

base-commit: 1833f648bc88dc8905ee8adce5e1363639594a68


