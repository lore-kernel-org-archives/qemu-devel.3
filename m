Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A716C369D3
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Apr 2025 17:59:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u6vPM-0005Ot-H2; Mon, 21 Apr 2025 13:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric_devolder@yahoo.com>)
 id 1u6vPK-0005Oi-OS
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 13:58:14 -0400
Received: from sonic317-32.consmr.mail.ne1.yahoo.com ([66.163.184.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eric_devolder@yahoo.com>)
 id 1u6vPH-0006Py-Pr
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 13:58:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1745258288; bh=N4WbbG5OxgkeboZOSVd/7dQU28rQnkshGJkf88qSbMg=;
 h=Date:From:To:Subject:References:From:Subject:Reply-To;
 b=CSFQLlVRhWMDW9xdAbzu04YKFXalj6VB33f4aIBjtAx7P3yNYcEidXfxZHju5n5aU0OXFwOqqZ+V/HTfl+pvl6PTsb0njBHLdgCAwxnQfhSKmW2BCvL8FkrHfNrtO2KwPxqmUS27dcqg/CBp1goIH48RZIU5WQis3V2mVu6L1KAX0twRR+nld5btUe5wwSfBI1Nx7+BlOTVWPDdvC5mL/a5ebV26HBnrMkQ4g4VLsZNgSWukz5pBslUY/AZq5qb2k1nGNtMPuy0/6re7ziT4QoDkEk/ucSz/lbE4qxWksPc0VAXX70PAr13QdPgFgsKXH998S+aZ+ESjCcSwA5Yc2A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1745258288; bh=QR9V5q7SijPp2qqD3yK7uqlIoXeOBCnrgnewJLndBEd=;
 h=X-Sonic-MF:Date:From:To:Subject:From:Subject;
 b=FaK45idNx+e2p7dJg+BxMJcHIuwkgUE4xVlKJgcUuziKvcBoYsDHO6IBD88KJWh44HelFEYG77gY5t5EoA/OyzJMKf828Ha/J4PioVfnkbhmatmbJug7XeUnb0JMZ7GHoZC5gwbRKMRGuxUrlQEtdnLtxrY7fzMcnC7vecbyrDQuerCKiiMxfV5yweKkQq0YuGwPy21CHWTXHXxDl9LJzyehebfg2JlYDM7lSDvUH3jYWx48VLrjvMieAa6AanJ+i/S+UyoL+u8DV50UMlEr3GMuDBou+YiZC8rosH4FBmY09Hxeu1DS45+GJxCFLYD0/GpHKiAC2W6+KbyRnku3Ag==
X-YMail-OSG: aXUvpewVM1lyFkkrU07n7WR22WZCYOb1MaxpVAHbLI40L8hLtB0V6qh0p1zFQiN
 Vx8al5KBG.l0vAPHz66_ml.LHyCKSryED8YA2zbjqHWTr5AubbWpQ.P6Wo0gzWCadL2adzLZxrIW
 6t1s1PLE798ZEaaaXT3EZOrsdAOi8G76SDzHT7yba_JKH9NM4dSYFpzlCKGoi1HJwYQ9qP5_k..k
 SLHCZskQ2mRmeAQQeGcYUWuuOpqjG3hX_7be2Hj2WpqlGcqW0BeEvy0vmlwrzQhqw.9WT4caIeea
 c0n53W_DlHsSpU6dI6RI.9P9DmGRJK7t2IUzQ6_ljv7tab_rCxODnMzg2Op_bOJu5HP8R1k9ESvh
 iqQHJZwmRX1XnyRovDwb33ZFR5MHqk9VX4E8VE7jfy369X9gdTVhoBK7A1MgULL3Z3MjKoh3p_HZ
 naKEjdQU87Er48NK70ZZnpzbwnNuwQg8pJ6bI8KXnVeLDuywcfG0CPnY9S31lLt61gVi7tpnnc81
 w.VcTx8HbaSUtbnQE4fMSTEUOAi66GwhME9ttLrOyfNEDa0FullOzqfPOshIpU6Bqjna0nCmxWYf
 ERgucYUyvBqc7hOIe8qUj1j72gun1tb41ULaWr7YuXJHucL8D0QYQRv8U5msl86VIKVa7VE09X5M
 PzJ1fNCsi0ruOIk4OJZClLvB9CbAaR6fVtrdDBKHxSn.l_Do4H1_ctcfSxftp18QKmvvXs2WevDd
 X2PBL0VozOs5ODCUuFCg9Jn73ZRve2jO_55i5_D1P9E2JCdaHKhAhi9PvjQC9POHnYn5bWuqsslY
 MIUgLTvZVLgcD6pEqFB6woNkY.RYS.Mw2cY6C0f.hKhB.HUPMiy3wLZVqzU4y0S7hPYtffgIe7LT
 bL3fQ1gLhPSkwSstGewVAs.D9bDGEDrkFnNbpCreayuuUcp8rYytWcm.pjpYQoa1VO4o6buMG8.S
 Qe.9__1G6fnFhmpfqHKcuKygfqo4tJ_uXJsRKqnB4ve2RnJwm.sm7T3a.xx4tRYnVDfSBJMfP2Yi
 XnZ3t7y.1PjNAo_nX0KXojJMb2HsweuFcTW6O7yyssIzitsskeOlpxR.5i7JKv4bA1DwWaHGEIsv
 xv1u8PuS_nYb1Xr66bCIcu6p8.O_IA4BRmtlOiHElnxgChpsansQWh34iCB1XDo4jV0cIfTWYbTn
 may1CUOt0I1ym5n2i8j_IfpwZcel3XbBpVUpqD7TZfvAWNFVq8jth.enw1BAj9BQsw11btQGd5JG
 0Cz7pCyHJzscUuzeHlPhu2lkJUViigBWbusIzC0c3XkNN1j7qt7Br47UHF1lSj5Td0yGbrTWO5aQ
 3q6ofhdAyuyNqQYiQpwr_t.Cw2EoO6flT740ncRz9jkcKkRUdHVFReF_S6xpsbdzF26cDlAYN1ax
 VVEiS4tJg0vGVbO_lW4uE9y9pl5mdsWCC5yHihoLBcU8q8ehzX2EC3soW39Xbr6kS73SCSb0zgsw
 Y_iNVuUuFuoNB4VqUl.ys5qKxw51cxtCsJL1V7Ft7cQXAu1kBmThsP_50H3BmzcBQcQEp5CZpBV5
 _KEISmipjCZ6BhioUtbZCxafUIY93D3y4.01Qiy7muQs8KJTMD1Zw77Mg_0.EXAegNJZp9riGdb.
 uA25xdao0GZeogSNaG6EwDJU.ouQrcvObRzXPm48QY6MY.hQopnYucZUWGuvs.W8ZYBm4YXkOh3d
 n5ffzbtCdQIqsV0cQWGfikdzAb_8PyomdNisRbr8dWJy8kl6z8Jc.9JZS4sTskWQNTCDisRKBf1w
 xA5Asl.ZU.3H3rbylekL6cUyfiC10zmL20dkO8G2utjL1B4qlQ.G99QZuXnYBSqkDis7NQik19gH
 rNa3zVQSbXv7.bblzKdori41wOU0ZDgpmSOwRK1yBeXYBb9gUiUD47saGJbUZbvmoOyHgUS5zHA6
 dZ0adUpwO3GeYb8oSDYfKF04DUNC2SaIQi5csCOkodkd3BeTmE_iKysGnOHpa5sIIPziOAZbur_5
 cOf9PAVQMCYBk.0wfO_qyQ5wvVMdmz9azrN0hYGFvkKWZBcw.KToyZ6Wyvk91j6eheudpN1iqpiq
 VLlGBY1au1tKEzX8pjqVFxmLXFDWP37Zbohpitc9hqEZWdWt1JWwbvqkW5cfln1IA6iTtW1Vkor2
 WqIxlJGLJ3WoUn2pV.EtHT7O92sb5BTWfAyWuYvFzsJLnHHR8Wt0LVek5R7yD6PEudcQUpI0_HT_
 o7PUXGJaHkZGBeHj9.OK6FIr3
X-Sonic-MF: <eric_devolder@yahoo.com>
X-Sonic-ID: 4f386132-a638-4bd7-8d03-aab77e1b710a
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic317.consmr.mail.ne1.yahoo.com with HTTP; Mon, 21 Apr 2025 17:58:08 +0000
Date: Mon, 21 Apr 2025 17:58:04 +0000 (UTC)
From: Eric DeVolder <eric_devolder@yahoo.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Message-ID: <89209876.67593.1745258284104@mail.yahoo.com>
Subject: riscv: AMO exception is incorrect
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <89209876.67593.1745258284104.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.23737 YMailNovation
Received-SPF: pass client-ip=66.163.184.43;
 envelope-from=eric_devolder@yahoo.com;
 helo=sonic317-32.consmr.mail.ne1.yahoo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

I've noticed what I believe to be an error in the RISC-V
implementation.=C2=A0 The RISC-V spec[1] states:

=C2=A0Note that load and load-reserved instructions generate load
=C2=A0exceptions, whereas store, storeconditional, and AMO instructions
=C2=A0generate store/AMO exceptions.

For an AMO operation, a translation page fault should record into
m/scause the value 15 Store/AMO Page Fault. Instead, I observe it
record 13 Load Page Fault.

Here is a look at this using the execlog plugin:

=C2=A00, 0x3fbf6dfee8, 0x8f5b02f, "amoswap.d=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zero,a5,(a1)", priv =
-> 0x0000000000000001, scause -> 0x000000000000000d
=C2=A00, 0xffffffff8031b5ac, 0x14021273, "csrrw=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 tp,sscratch,tp", tp -> 0xffffffd600926400

In this scenario a Linux user-space app issues the AMO to an address
that is not yet mapped, which causes the exception 0xd 13 Load Page
Fault.

I've spent time looking into this. The AMO operation, at run-time
(after TCG), has a call tree that looks like:

=C2=A0code_gen_buffer
=C2=A0 do_ld8_mmu
=C2=A0=C2=A0 mmu_lookup
=C2=A0=C2=A0=C2=A0 mmu_lookup1
=C2=A0=C2=A0=C2=A0=C2=A0 tlb_fill
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu_riscv_tlb_fill
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 get_physical_address

As the AMO starts with the read/load part of the operation, the
translation fails since the pte.V=3D0 (not yet mapped), and because
get_physical_address is told access_type=3DMMU_DATA_LOAD, upon return
the raise_mmu_exception() turns that MMU_DATA_LOAD into a
RISCV_EXCP_LOAD_PAGE_FAULT.

This example is a Linux scenario, and I think that I see the Load Page
Fault happen, and then upon return from the exception handler, a Store
Page fault happens, after which the AMO is able to complete. So Linux
has been "gracefully" covering this situation.

I've looked into trying to detect this condition and change the
exception_index/cause accordingly. Fundamentally there would need to
be state reachable via get_physical_adress() that can indicate an AMO.
In the short time I've looked at this, I can't find it.

Advice/tips welcome.

I'm on stable-9.1 <v9.1.1> sha 0ff5ab6f57a2.

Thanks,
Eric

[1] riscv-privileged-20211203.pdf, 3.1.15 Machine Cause Register

