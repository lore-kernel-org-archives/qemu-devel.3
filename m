Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE3DC35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 14:16:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuuBO-0003mQ-4M; Wed, 19 Mar 2025 10:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.67dacd07.v1-4ae52f81232d42ab8a893bce3e1f89d8@bounce.vates.tech>)
 id 1tuuBF-0003a8-K1
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 10:14:01 -0400
Received: from mail177-1.suw61.mandrillapp.com ([198.2.177.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.67dacd07.v1-4ae52f81232d42ab8a893bce3e1f89d8@bounce.vates.tech>)
 id 1tuuBB-00071K-Im
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 10:14:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
 s=mte1; t=1742392583; x=1742662583;
 bh=S2HwWyjFnN9+yZcO348glRXKWzLF/ORVGltfzHFXYyc=;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Feedback-ID:
 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
 Subject:From;
 b=Ga+cHosNDnFzPwmP+RZ8J6sWg5650K7apJNsFjJDPEEWgCabmI3SAz5JQ56KTTZi/
 U7m/CFJm5NMyiWKkxptmzRpI81HuuIxv5224dkBJz8n+moHmKijhIqdIMl2Y09aWZy
 CksmMVPl0ZEvWZToG74frU2gKKxjTeF0IF8U0joyc7eIAMt33eXfdtpnRbf0K1dVVU
 7zReiwdffnD7EkW4E3viQ+HTvC9Tno9LYrn2GzC/eIDGATcLLIcq/l1l2EV3cqGjFH
 BYurFoWE4zLpIrNh41Cm0Ku8I3FIEZkXZpToEoKMSw2XTNP0wnVwciPgN9WlPNZiyS
 MwZi8LgAvqw0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
 t=1742392583; x=1742653083; i=anthony.perard@vates.tech;
 bh=S2HwWyjFnN9+yZcO348glRXKWzLF/ORVGltfzHFXYyc=;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Feedback-ID:
 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
 Subject:From;
 b=wdH1BnoaMvPYGRdFees2273xUlY1chPNF8zTusstQGKymsbzELW/XZKnx+qcoFfQN
 sv0lPiVi7XSjAWDweP++Q9fzlhXBW/gTYW4s/RN0kBjl2VAEm8AC8R4K02AB3iy6nQ
 bzXe/E52xMMChgQd65lA587XR1ThocjwUxrYA4gK8OFfxaoUFypYPK4EF6nXOg8I6Q
 eV/tGL9l80ZVm/R2BWrt94Ssn1jx/jFalWr8ypPl2VJ2WAy1sA1sxs2FeA+053XZDd
 Lz5OSrML3RLeLJe0cKP+QwLq5VdDF7Bj4modp8dGqKrszOU3F+/KIZj9zhoWGoaqtU
 rC71U9O8jTUzw==
Received: from pmta14.mandrill.prod.suw01.rsglab.com (localhost [127.0.0.1])
 by mail177-1.suw61.mandrillapp.com (Mailchimp) with ESMTP id 4ZHqxg0VYgzBsThdg
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 13:56:23 +0000 (GMT)
From: "Anthony PERARD" <anthony.perard@vates.tech>
Subject: =?utf-8?Q?Re:=20[PATCH=20v6=2013/18]=20system/xen:=20remove=20inline=20stubs?=
Received: from [37.26.189.201] by mandrillapp.com id
 4ae52f81232d42ab8a893bce3e1f89d8; Wed, 19 Mar 2025 13:56:23 +0000
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1742392581417
To: "Pierrick Bouvier" <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, "Paul Durrant" <paul@xen.org>,
 xen-devel@lists.xenproject.org, "David Hildenbrand" <david@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-riscv@nongnu.org,
 "Liu Zhiwei" <zhiwei_liu@linux.alibaba.com>,
 "Paolo Bonzini" <pbonzini@redhat.com>,
 "Harsh Prateek Bora" <harshpb@linux.ibm.com>, alex.bennee@linaro.org,
 manos.pitsidianakis@linaro.org,
 "Daniel Henrique Barboza" <danielhb413@gmail.com>,
 "Richard Henderson" <richard.henderson@linaro.org>,
 "Alistair Francis" <alistair.francis@wdc.com>, qemu-ppc@nongnu.org,
 "=?utf-8?Q?Philippe=20Mathieu-Daud=C3=A9?=" <philmd@linaro.org>,
 "Weiwei Li" <liwei1518@gmail.com>, kvm@vger.kernel.org,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Peter Xu" <peterx@redhat.com>,
 "Yoshinori Sato" <ysato@users.sourceforge.jp>,
 "Stefano Stabellini" <sstabellini@kernel.org>,
 "Nicholas Piggin" <npiggin@gmail.com>
Message-Id: <Z9rNBFsWR39czUGQ@l14>
References: <20250317183417.285700-1-pierrick.bouvier@linaro.org>
 <20250317183417.285700-14-pierrick.bouvier@linaro.org>
In-Reply-To: <20250317183417.285700-14-pierrick.bouvier@linaro.org>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,
 =20including=20all=20headers,
 =20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.4ae52f81232d42ab8a893bce3e1f89d8?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20250319:md
Date: Wed, 19 Mar 2025 13:56:23 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=198.2.177.1;
 envelope-from=bounce-md_30504962.67dacd07.v1-4ae52f81232d42ab8a893bce3e1f89d8@bounce.vates.tech;
 helo=mail177-1.suw61.mandrillapp.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Mar 17, 2025 at 11:34:12AM -0700, Pierrick Bouvier wrote:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Anthony PERARD <anthony.perard@vates.tech>

Thanks,

-- 

Anthony Perard | Vates XCP-ng Developer

XCP-ng & Xen Orchestra - Vates solutions

web: https://vates.tech


