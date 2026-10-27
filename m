Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF6D606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 15:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=1Nek6QBs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLjZ2-0000zy-Db; Tue, 27 Oct 2026 11:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xLjYa-0000tM-Dd
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:57:55 -0400
Received: from npq-east2-cluster1-host3-snip4-10.eps.apple.com ([57.103.77.13]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xLjYX-0005jt-TA
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:57:48 -0400
Received: from outbound.ci.icloud.com (unknown [10.168.160.109])
 by p00-icloudmta-junk-forwarder-us-central-1k-1 (Postfix) with ESMTPS id
 0641D180009C; Tue, 27 Oct 2026 15:57:43 +0000 (UTC)
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPS id
 54B8D18004A7; Tue, 27 Oct 2026 15:57:42 +0000 (UTC)
X-ICL-RepId: 01a17e14-e996-78b4-898e-87546135042b
X-Suspected-Spam: true
X-ICL-Out-Info: HUtFB0MEWwJECUgBTUQeDx1VABMeXhsPRA9WAlUORQZHF0kLTVIPDx1WEFIAUg9yBVcIQQhTAlEEWBpfCBkNQFBfHA4YWRtAFV0RUBlWCV4VFx5BTUUID0YZEFYBWFZdBU0aXBhZDxwTUFZaDlsERxQXG1wAFxtGAgQjAl8ARQJeCVYBMBcPVk1MFkMfUg9bE00ZUQFSRVQCGRVaCQpXAEALTgJdBVwDRQxPAFoZXgtCDkkeXBoGXRhYFVYJdx5cAEsdVwRUH1MSVR0dC0VVEgRACFZQVB5BBFYVbAlYBlMZVw==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1793116663; x=1824652663;
 bh=nkonLbd8Nvdqxf538/kLmecZrCNMHAu7XOeiT0+3JFE=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:x-icloud-hme;
 b=1Nek6QBsRWAyGb55CvsBwb/TfX/1DNlZoCkVOhKAg/mwz3Veo6Ub8V96uecXeVCm4T6rudFevPQfjgglOArzdqYGE5y/07oE3cEIOV5gM1PUya046A9g+NvknmhgcCxAVBfpzkPrQN7T6kISez2RGl7wkeDDFJX6I3W5rWHvLws4t1mh7gYu2WTUYlk3b+f/sagYIuv2QiELoWN5uS5+D0TAm5CK+pTjA/rVnLgxpaewbQycUQCT2p8fQDqGurx246zSJcnZ6NeUJUz+EtqP9LfHPnRpDSOMNSxrgf8ecAiHs5rH4NbA9ynUKMsaNuWmzdrz02V7BsXIxDeIBN3aqQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPSA id
 131F41800154; Tue, 27 Oct 2026 15:57:39 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v2 00/18] whpx: i386: updates for QEMU 11.2
Date: Tue, 27 Oct 2026 16:57:19 +0100
Message-ID: <20261027155737.59271-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA2MyBTYWx0ZWRfXw71m/SEYjQfE
 6+MRXdXvAeZWZn/Hy90kHYusntHTWnktYnE4O6Pj/W0/GNxpbwLGHuC3SWrK5YdlIqHWxCoz8FM
 Qo3p/hTad0IFqw19yY/lW+vQs3/A5JHPq4jDEcBKAkzagqSlzoDK8HLRvEWkE5ryO3oDlF2kTFa
 5dddu3edbwNPuvI6t955AwpaCXKbavYR49IKsMTuP6UfQRBTUzS1UTmDVrzM7ZFwCgnyTqFpoZY
 QsMnro5Ru7vkEWdn9mOVZdZTj8ptmXFc+BPAov96bCb2pRZaVCk1RNcmTPMvm4CvogG3h1LQUqj
 tZI8TxTA0mvGMZnV77FOn8hR6tj1QsDysBUjvwV2sf+G48Jzl8ucZqWY3AH3mY=
X-Proofpoint-ORIG-GUID: Xlc_7qFCNZdI5FJLeGpshvDNCl546Gci
X-Proofpoint-GUID: Xlc_7qFCNZdI5FJLeGpshvDNCl546Gci
X-Authority-Info-Out: v=2.4 cv=dZmNHHXe c=1 sm=1 tr=0 ts=6ae0c9f6
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=qtDaSVgAUBJJrJf6o1kA:9 a=QEXdDO2ut3YA:10
X-JNJ: AAAAAAABjXYFnF0sj5jdoIm1gkDrT+0pzLpE7TxDs1SURbGrsL6mtnGMzTQ2QPT80Hm/dECZIVcsAZ6a7zazSjjmaIn4NSevfG1dpVjWyusxSfAwhUdDyWBcJaJGVXIZJPHOMFA8cog9+SK2hLIi41bxM9wrhjHoM0fXMTy6D6T7P5zgCJUR7FDolt1GoDEVtmq8IPOI/nUWMK0Bg4Y51IlGBCne2ITKlCYMHOvNYMoWgx/xi/GiGsxQYs66zs/+3n6uHyqijzkynnJ+SyLZ/UfBdZF545+GsCRV20Pp9EM/pFW8FT+Oc468PhRpBWL0nTSaBBZ2FU1PtGjMH6R5f0NbQXjJNeBEEaUfVACtxp0+Q+GldrNfZn7flcsNU4bSfAl455OChGxEJJXq3ci0df1jinXuWKmwCM8QeDpaMmVZAhNRc1QoHseYjZz/KGy7/7laqeAAU2VdlQq+ilM0TZ4Quf+pNAeZJHQ61HH/Nt6JBvMOlcIcLn1nl2gzZ97HpKrbXATXEvenYrRxULrHoIJ7/BZ62OhLLqs3Y7QnQmtO5yTVvm2whQy9H59N/y57D1zH9VY6FQmLm3W6NqMf/HfnFBYG5VsGe05Q4IUqa8UwYn0ZYdG8fnCuxu6DI7SLbMPshZy7bmdJecUX2MQhsKX+POWtCRI/vciFzCv6dJqzqjvjaabEIIgyqOTa/uhymrgT30+VXMOMEiQSwSnS8033XSVjDT7Q2GjTVyUHpDKRAm84ri2qpfboHQW7i+8SfYGn+0lWfzPw+3qV91zft/7SH99iCOkRL+DIZ8ODkx4uWGQygbr7EcvDBeK54OioTzaAqDAy3tLUTnOm84RhTHZSwZzQ8jB8Lyc7R0tab2NEjkkZ8gI/H+H41ddo9k4YLlfcuCgWW/ZmVZrwksn3ooHvTlg/+zV6X+FKZI+0K73MXf58pJsvTYSYvIKA9HwiOLrb77XWGYvf+KS1pYPGPX1YlAx9tcs
 021/vchdtT+YXjhTO0R5S/W+CWv/pPXcdA2BJeLRr65f0XUwQD78qFSA9R/3ARrWqx22TXARG1fqy1rxywUuRt+z0ha+6Csakr4RdBIZeFZPn+jeRITQMt2wJX1IyB/TIo98Aodb9pBDMAkR87Wuw0K2xLvp69O+FLloBzdTD8iVFSp8A9d18OdLZKlQ/Y5TRGs/pMNm3n0nEpZQ0fsibGXezB3SpFb5kv6m4WwxF3hl4xYEYigXPJo1USZqcjmGF/dnyiZt1J65w1K2ePGiE0ozrOvtanaHoEJna1VfH37gx
Received-SPF: pass client-ip=57.103.77.13;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

v2:

Interrupt controller rework to use the MSHV implementation.
A lot more register save/restore.
Restoring support for older Windows 10 releases.
CPUID fixes.

v1:
Experimental support for save/restore, a lot more robustness on
reboots are the highlights of this one.

Akshey Taneja (2):
  whpx: i386: do not require ProcessorFeaturesBanks on legacy Windows
  whpx: i386: fall back to xAPIC when the MSR exit bitmap is unavailable

Boden Randin (1):
  whpx: i386: avoid updating hflags for vmexits

Doug Cook (1):
  target/i386/whpx: fix VMX capability MSR values

Doug Cook (WINDOWS) (2):
  target/i386/whpx: whpx_get_xsave_state error handling
  target/i386/whpx: handle processor reset

Kostas Chatzikokolakis (1):
  whpx: i386: forward the dynamic EBX of CPUID[0xD] sub-leaves 0 and 1,
    not 1 and 2

Mohamed Mediouni (10):
  whpx: i386: get APIC state before VM save
  whpx: i386: fix TPR encodings for local APIC
  whpx: i386: save/restore xss
  whpx: i386: make nested virtualisation init failure non-fatal
  whpx: i386: allow migration for restricted scenarios
  target/arm/whpx: handle processor reset
  whpx: apic: migrate APIC implementation to new interface
  whpx: i386: also save debug registers
  whpx: i386: save/restore pending interruption/events
  whpx: docs: update for experimental VM save/restore support

Pierrick Bouvier (1):
  multi-target: restrict whpx-accel-*-cpu to matching target

 accel/whpx/whpx-common.c       |   8 +
 docs/system/whpx.rst           |  12 +
 include/system/whpx-internal.h |   6 +-
 target/arm/whpx/whpx-all.c     |  10 +-
 target/i386/whpx/whpx-all.c    | 436 ++++++++++++++++++++++++++++-----
 target/i386/whpx/whpx-apic.c   | 307 ++++++++++++++++++++++-
 6 files changed, 699 insertions(+), 80 deletions(-)

-- 
2.54.0 (Apple Git-157)


