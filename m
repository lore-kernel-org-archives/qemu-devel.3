Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65CE606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 00:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256 header.s=a2048 header.b=mZXqygcW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW0aD-0005tG-1q; Tue, 24 Nov 2026 19:09:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.seker@aol.com>) id 1xW0a7-0005sD-8p
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 19:09:51 -0500
Received: from sonic302-22.consmr.mail.ne1.yahoo.com ([66.163.186.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <m.seker@aol.com>) id 1xW0a5-0000cn-91
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 19:09:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1795565386; bh=W+7IsrM5ZC/JJZOWupK/V3dPLXHE+gHlJGOI3zWwkVM=;
 h=From:To:Subject:Date:In-Reply-To:References:From:Subject:Reply-To:Content-Type;
 b=mZXqygcWJ6roTZZw+fnOBBqjm7qBqb6Sxo99/3f6HHYxrDlHdwfXtIO56qvDrt+95aY9uQGbzcnZdx1usPiPmK4BwYl6+sgUdPdcqQpumGlP1UXLXPdBQJsBNtKF4pHxY1ZFL5FkxbY4tMbfcxW6EENiianhHrsu2/rvnvWQhnSZxC7zR2M/fLF7kM9vkBkqwZLchtFBoEmwrPyl7btJRvkjs1FCzP8e9t8ZWwZ26xm/U0BTGOvEOW71m+l3S6DiGUU0po0WCIaKmxMPiNXbaRsZHDKF8oiAAeCQ634ky1rpDmXaKidyHMcoTAIovYEx7oNsZkVzzqYLgxLrTBwgAw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1795565386; bh=X+ACqqjCLPb9T7+BtGMQjBC9gF2VXkFd4qXp848V7hw=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=cIoTJ7Xq+yAKYap/rHUEnqyKqMd3jZPV2/NORDxk/pFUcStAeayhp1kl+YZyTuJOiwkJ1JFTMrnmo5hM2MfCxfzMDufMLOLu3iYLkAHISBJxy1/PCI+brxH16XhyWiPG7bD22vYHPqiGxCCNanDKV2kq70zUWzmIlTCM/bgmdgAEeFXVry5cLkM5ayAwqwAiVngtHUix0lBjbLLuDS/kHPuZA9PpYsUi+EZUyYkBm6GyOIsOunvHwulYclS+gvAB1z8aY2o8KP9RkoyKWvijeF4eDDM7NHcWxYtdz8FdC3NqjV76BHr0F6hYX90OuMAlemDBy1bxeK1F4qfgT8MT6w==
X-YMail-OSG: 8JP.AuoVM1n9AvsrtbHUir0.DEq82dgjxWjCcNBaf2sDS2mbFwT10Z2zrqjO2Qi
 NOBYvbsd01WG5IniN.QuhBX3BmPlh7wap.ppQ1B87WseEa4iTFsjJMHbOp3jk.IxPsSIuHi6NCjV
 epJkhFSFRdhwowsBjcQszSYaRALqLLpPxRaQXYu_UQ9VfnCEKCfdQAWS5PGKQc7jB8HhGQO9XuJ0
 iR2xMBGeHdNuKzhKPWosIc0l2eslBq5.Tz4zoNK0W6gynhDXQr2lJS8u_.5Yv12azMc74_Z6mBnV
 NeS34TwDCdS3Uh7GNRxJvtMtfG6jZIE44WNtrXa7Iy0Y0mYq5viPuNbF9nEnfDS3erfOli3hk2vT
 HnTX7DGsh57CH0HG2GPA6zEIayslGHUetQmjlx6eP7djAqWS_GmAUzk8gvSBLUy9XcITQfpLUk9J
 yWc0k_AkY8IeLo8YSgII7NNGQACFuSCQFo8_zsG2FOp0LgCtejxyFVmEld2hwE1hCO1GPM5wevgR
 89vaYDaT8T4cdDtb0t3k3eKs2Np_s0.kTkohO68NiR1QIejD1sAayhloSDW9MrhCL0oX_UqV6JEk
 a6id5Y1s3dvbasnvJ7CKrvC_ox4EgFUry5oeZNqAvOpgCo7PGGjF1ICmM.G8FZjkwjsviF5TYnYB
 kOquIdHEHIQ7nl8GTOF.ZtDmhfmoBimBIdnNQwncHhjMryrLvyYxBkvWM4eW1BW_fB5M.GSoykSw
 LbNjvk38zsMFZmhc0fn70eUqz3FearW0P.yXKxuWOBHo4V4iFdEjBqhDNDLe88.d8P07WXfaDVHM
 Stmnn78MKDZOtxcbGuKj5_YjBPxRjUQNUHn.ILR5pSreSnZ06NmsRY1bPGP.Ix6u1iSNIthpHr84
 8VJrZ04NGV_vvwcPQpuubtj7DH0kLHC7RYXHzSyMY.SxrIzTDlSvOaH0RwzZIJjmmuZvjTgfEIGc
 wAhe8hPjQo0.aqo1PGaClDwLMpssnfNnZD7wd6bz0sQ.TBM4NdRfs0MXTc5_L7CqhzDWGJwJ2eQo
 DL1SY.zCUirVSg.ND5xKc_f8gIIE21eDGyQ.Oo121CBMZbIBuT2Jkly_2BgMWfdeVwo6ZfuKRT7f
 7Ppi31sIqaU2UdkZGHvBOjTCD2KTl24xz61wU5tdD..mKoUCBoJBxz9lBQz7x8u_edWBZRURhjO.
 KPbMAcg6DQGuqsX3FY0lHnT3Rl.2CmJQhop3VRvDWvHdbO0u3uReXS_eFBCnvA.BQHoWWiHOe0k.
 4Dp7TGyi7cI7.CfLgOGzwDU7iZt6xC0YeKy4l0qYpSPoF2YipTmSADL4.t7aiPMW2eaLPUpybqrX
 yvtBLb9mqeEJhHHy.58AUlcZ3L8PFGBeWkTpqPdtBFKB6qof5qfRfyJaxGLGxQj1vD5oeHyW3g4q
 6cL4dk5nbWBjcf0qeOLSJ7ct3kh26tEq4BimcGz26qasvbaYwSJRYUvznKYP_zfrzcaY266R3tNP
 3nLkF2TJkT381otse4eBFfiyERudMJ10txHdkhZ7yzd7JFiT.AirmVJbC86zi97wmheKS65WZRM7
 1ThfMy5KTjEhpASrzFjB.SO0HhOrnhyxKD1zax17yByMfoSe2hwRwimztydPMF0AymRhLs6kKmar
 nL8w7Wzyk9EhNs2QkSUDRZPO8wzri0JNCU3xq2cta_RxfikAgtN8H7WM8Kfu13dD7TlQbxmzxJzt
 ucapj08_C8W9O67XPIuPcRrGECYRsQ1xThnKVBPddn5mBZ3Me6K3d.ktSNGkZFi1mjU1rFII97o9
 FXBnZ3IMqYH9onwKGSzJ2hC51.JRYHjG72oZEHCG8xbQlxhIQKcpFkyv4wATSkC2Aa2LSwLme.8y
 IwybIPr82Uwo00JcVuCRzYuWqLVPVslsrKAMFkJqyEYewArKlMl7hT15TyCzGmkFT9.Fy8vxAi7g
 Gnlmu8htlBnxHT7AWluPMqOYpVNx0IYDRYZGctVOkiSHHKWuoJqUCaqUzn3oWBus30r3j6BIYClR
 2lG2t35.IGEw2RbZggogD5iA3Qg9CfyUOpjxnYnp_QPmSjfhaZeqKI8teGxlWAGWG73k5487ZI_m
 S5tjjzegbV7St9mzt6K4lsdmqHlz3aCbEjz0JbGyb5YlSssd6i2KTbU4YisgApOjjzh9QQdNPK7D
 tIOpjaA_kiCV6VP6sunRUHVHJRhhgulSg9lgChdv7cawiyGSEq6f_.TRM.4Pg0Ok3IFpiJfPs55o
 Tq9E9PtKmnWBtYfIVGfubtFvY_Lupcpr2ouGS2F7_jFIJfw--
X-Sonic-MF: <m.seker@aol.com>
X-Sonic-ID: d6954b92-8799-42e2-8dc8-71650e96251f
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic302.consmr.mail.ne1.yahoo.com with HTTP; Wed, 25 Nov 2026 00:09:46 +0000
Received: by hermes--production-ir2-7c4859dc89-v5pln (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 550b92a6d5fcd8531b296aa577153f54; 
 Wed, 25 Nov 2026 00:09:42 +0000 (UTC)
From: Murat Seker <m.seker@aol.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH] accel/tcg: Skip clean MMU modes when resetting TLB dirty
 flags
Date: Wed, 25 Nov 2026 00:09:39 +0000
Message-ID: <20261125000939.41288-1-m.seker@aol.com>
X-Mailer: git-send-email 2.53.1
In-Reply-To: <067f8bd5-249b-4d20-8b27-f77594efdb4e@linaro.org>
References: <067f8bd5-249b-4d20-8b27-f77594efdb4e@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.163.186.148; envelope-from=m.seker@aol.com;
 helo=sonic302-22.consmr.mail.ne1.yahoo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/23/26 15:55, Richard Henderson wrote:
> On 11/1/26 18:27, Murat Seker wrote:
>> tlb_reset_dirty() scans every MMU mode, including modes whose TLBs
>> contain no entries. These scans waste work while holding the TLB lock.
>>
>> Use the dirty MMU bitmap to scan only modes that may contain entries.
>> A clear bit indicates an empty TLB, so skipping those modes preserves
>> the dirty flag reset behavior and reduces time spent under the lock.
>
> How much time?

I instrumented tlb_reset_dirty() and booted edk2 on
qemu-system-aarch64 -M virt -cpu max (gic-version=3 above 8 vCPUs),
TCG, Apple M4 Max, 10 runs each. Almost all calls come from
tlb_protect_code() as new code pages are translated, and each one
resets every vCPU, so the cost scales with -smp. Total time in
tlb_reset_dirty() per boot (median):

  -smp   calls      base       ctz loop   bit test
     4     2568    10.17 ms    0.52 ms    0.53 ms
   100    64200   261.3  ms    1.59 ms    1.64 ms
   512   328704  1561.7  ms    6.09 ms    6.61 ms

The secondary vCPUs are parked in firmware with empty TLBs, so this
is close to best case; a guest with all vCPUs active will see less
benefit. Migration itself barely calls this path.

> For hosts with out ctz, like riscv without Zbb, does it slow things
> down?  Is a simple
>
>     if (dirty & (1 << mmu_idx))
>
> test just as good?

Yes. It is within noise of the ctz loop. I've sent v2
using that.

Thanks,
Murat

