Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 306C2C88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 20:52:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x58Dq-0002Cv-Oy; Fri, 11 Sep 2026 16:51:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paul@galbraiths.ca>)
 id 1x58Do-0002Bq-O1
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 16:51:44 -0400
Received: from fout-a2-smtp.messagingengine.com ([103.168.172.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paul@galbraiths.ca>)
 id 1x58Dl-0008Oc-OF
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 16:51:44 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id 5E734EC00C5;
 Fri, 11 Sep 2026 15:02:36 -0400 (EDT)
Received: from phl-imap-06 ([10.202.2.83])
 by phl-compute-05.internal (MEProxy); Fri, 11 Sep 2026 15:02:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=galbraiths.ca;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1789153356; x=1789239756; bh=Mtmn5trbF41sWc5TxKdyhIVssohrwaIG
 YPYFBr1WPII=; b=bIJAca9XWBJIn3Izuw0iJU2kOGRzefGthQBdUeGimpqU6/Ta
 MsA8BinX2DAfQvDltnkypU5ZHiF+layyJw2kfjgU5LuznBsX/PE1zyjQm4h2ki1f
 aKIbOj84M/lEQE+FpbEDq0hGnJZlJwS6CDQyLFzDxUjjf5ILT1sHtX1ew04A8kvj
 VrtSLJsdBDI3QeBCqsIemJquU69UyXAATz7uv5aWS+5iD/PoLvmotjTPxkoP5yCS
 sUPvJWFBryTNXz+3cDEbepJ4vL8MRRa8ST2TFUb8VTcax5I9LTYFjpJFIt5+fYfa
 uhxPrwvWz8W3a3TQ1luYa7hxc9807R7QAZmB9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789153356; x=
 1789239756; bh=Mtmn5trbF41sWc5TxKdyhIVssohrwaIGYPYFBr1WPII=; b=V
 b+6qIW+iLcw2DOMGX6/EdBT/8JWmCXU5tug6O94Yi4JOWubUJ+A/4zNSkwfZKRzg
 j6fD4cIddJPmBiGCZ9jijxuCd+ZN7dHb9EPDystMGJXhEnPK6wQXce77Oav1Ksb5
 jLrrILm5FlLrO8KWw7WwJ3U/s2YpdMz+oYOX3jcmovfMXEgBXLSOqcXM2bDys+tW
 ZyjaE/8JbVq5M6pwNx8SZQqOHptO/ueVLHUfOAmdEhQDrk5U1qVY7Iyjhqs+fVu7
 vJn6475y55bT05N+AtYJ1AuQdNKMP3ud5Xz7nFne1aVUWBuIi3EmNnNkMM5ahwh1
 /qn1LK8CwMJ+B51uG2xcw==
X-ME-Sender: <xms:TFCkajImQ-6tkDzb_teqLtXeIRp940JZ54tRkkLr26ODYCkv0aagfw>
 <xme:TFCkah8DjzQ0ma82yTuMift1qlMxLSmIE5-YFPc0AptdDiKJCPNM4vCGf7R1A3D4D
 fTMWAxRcCPfajkse9laLoebdZzlv_ysH3bZGi8dUcdaLZ1Crqw1NWXi>
X-ME-Proxy-Cause: dmFkZTFCXhTt1S6uVXg9Li4WnGM1Gnz39/1VUNiDr2Ism1ZTFqBt3ZaIl+a4unjxVlpQU+
 GGZGrLXcJEV8zRj4s8t8AAwwxVkqE5Syi33ijui92Ir9y03VAms90kpDApkfrAVkuIwO+d
 YH6Zs3mrGG1bw7ydv6huAK3lutEowZtFEN+w/9gH+S8krzpK4k9v5Uf4CBO2xYHCB1+USk
 jzZReJOi6jnijad4D3UFQTv58556GIKpsY0pNOV6n1jd6SDFhw39uA6lyBBBLaC7F81nAI
 jli0TlBB8RmVWDe9X88oiAclh13OkhnCG0zRmXF3zlcOyp/Gsn95wumtQDJ4hcUXv45pid
 OTV9rvzBKQzvD9n+PWYCeVVLcj2MeIIn/9LWrEmxPalG+YvJRq9CYAIu5jrRXiXKaImTzt
 wfEma14s32THk8NcoaFASEClj2B6WcoyR9HTAPjcgY74kjmhrTu4WiI5e7XfnaKBF0ubNv
 GWg3RWKQQ6FpxHCXHgQR9obsRP8z6TRRp3TPEA7PF7W/usqJQUbjj/Oqm+2/94edY6Pzfv
 303p96N0+b2dWq96pnRK0JafgCH1q/eUZLBG53AVlqMrZ0EJ8ZUjze1pxw+LCE8rI4TLEo
 jNQ25i5nZ4MheLKb32B0mG7KWRaYBNvY0RlD36cQYg+kZRMN6OX53mFbVGQw
X-ME-Proxy: <xmx:TFCkatrwbywkIfcpq2aprByYHYTgvI0Q8t0t3hFrvGf9Xo9yVrnR8w>
 <xmx:TFCkanFg10RsjCbSF5EAz_Tpo1qUwPbI66DayRYt2_qc5aUlF3gdsw>
 <xmx:TFCkanmeA-vd3BfRyVCtfY0kd7UxNEFgvp8vZCje_8ywOvc_Y1fAWQ>
 <xmx:TFCkaimzQT_a6bTZRxm6PN-B6vay44OU9WtF-JpU9dQmnWY246CEag>
 <xmx:TFCkapDp4qcpa2XC24Z05e2IcUZvNMgaWAtkW_60o12qeE2_RwFdMyNN>
Feedback-ID: i00314697:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 2C0C4240009A; Fri, 11 Sep 2026 15:02:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Fri, 11 Sep 2026 15:02:15 -0400
From: "Paul Galbraith" <paul@galbraiths.ca>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org
Message-Id: <4251704f-a202-44d1-890d-f7a2fe89ebb1@app.fastmail.com>
In-Reply-To: <b22ce8dc-023b-4de2-b821-0624deb120bd@app.fastmail.com>
References: <6c5fca8e-b9f4-48a0-a070-42f10d1f942b@app.fastmail.com>
 <b22ce8dc-023b-4de2-b821-0624deb120bd@app.fastmail.com>
Subject: Re: [PATCH] target/i386/tcg: fix EIP truncation for wrapping 16-bit
 near branches
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=103.168.172.145; envelope-from=paul@galbraiths.ca;
 helo=fout-a2-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

v2 is out, now a two-patch series with the regression test split out:

https://lore.kernel.org/qemu-devel/20260910180517.97-1-paul@galbraiths.ca/

Paul

On Thu, 10 Sep 2026, at 13:13, Paul Galbraith wrote:
> Ping on this one.
> 
> Short version: in a 16-bit code segment, a near CALL or JMP rel16 that only
> reaches its target by wrapping EIP through 0xFFFF runs with EIP left
> untruncated. The SDM has the 16-bit form truncate EIP to 16 bits, so in my
> test the branch should land at CS:0x0020, and instead execution carries on at
> EIP 0x10020.
> 
> It's fiddly to hit. You need all four of these at once:
> 
>   - a 16-bit code segment, D/B clear, so it really is a rel16 and EIP really
>     is masked to 16 bits
> 
>   - a cs_base that isn't page aligned. If it is aligned, the wrap always
>     crosses a page boundary in the linear address too, and the existing
>     same-page test happens to give the right answer
> 
>   - the untruncated linear target landing in the same guest page as the start
>     of the TB, which is what makes gen_jmp_rel() skip the masking
> 
>   - a CF_PCREL translation. It goes away under -d nochain and under
>     -accel tcg,one-insn-per-tb=on, both of which set CF_NO_GOTO_TB and force
>     the masking back on
> 
> One thing I got wrong in v1: it dropped the data16-in-code32 guard on the
> assumption that the new condition subsumed it. It doesn't. That guard is
> there for a different case, EIP starting out above the mask, so v1 would have
> swapped one problem for another. v2 does something narrower and leaves the
> guard where it is.
> 
> The test is the same test with the same geometry, just split out into its own
> patch and wired into tests/tcg/i386/system/meson.build now that the tcg tests
> meson rework has landed.
> 
> I'll send v2 as a new thread shortly and link it back here.
> 
> Paul
> 

