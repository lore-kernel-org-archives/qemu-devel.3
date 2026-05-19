Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EADF5CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 13:42:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPKhv-00033p-6v; Tue, 19 May 2026 09:42:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wPKht-000327-Pj; Tue, 19 May 2026 09:42:01 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wPKhr-0002Ce-Fg; Tue, 19 May 2026 09:42:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1779198115; x=1779802915; i=deller@gmx.de;
 bh=9NSpFAIT+rHECM/nin5/RnShhy/COhPn5oia1/1O3YU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=O5Ri+ZnOWcQ7SWmLEM4keyISGF78VEoGjVgSxq/K4ttmb64X9c7+EAgEEYZrHKmT
 3vXou04Rdi4wIL1Q0O5NjM57BjdPoZd4wKdIEfzvrO0zWcr6Wxz9EdUXwBD6wQnYI
 HHMEEVz0FXqg+mKlYMfZxe0JynzkdRSVNlLLHvo0RWUXoSABw1eW5KcJpwxAbZK6+
 gbDoIDRNmVqN5fX8SUzxb+2moJNZHabWUx263qAvAmT9damY3IN5rQwKxucFyERBR
 RfFqLKneMkDwuSdguWK5b56oHb9Dn8MFl0CExVIhseobsOOeLBYf2Rya4zsT3w9eR
 Zh+Zqr+OJyg2OmzPDw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3KTy-1xPVzt1wSw-0177Aw; Tue, 19
 May 2026 15:41:55 +0200
Message-ID: <1cec55dc-6cb8-4bfa-b8df-c0dcef28ddd9@gmx.de>
Date: Tue, 19 May 2026 15:41:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] linux-user/sh4: Fix target_ucontext tuc_link field
 type
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-stable@nongnu.org
References: <20260514165526.1530386-1-mattst88@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260514165526.1530386-1-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AlVhrPb6JyK6VmeV5n8GxvLekKfPA72tb9r1uN+2Ysos+UB1l3q
 AYM2GTuoBuiBTgdB6d0yBKkBOyrLblcM6KUaJiuJWfVxxj0SP+ac/3OMdB6k4sGpGqOOaTd
 72AOqA3bUu32LHRgIsTsLKmvhof+hh9DtHJQ8DHneAMpK+lcUZhzlt/hQtHUVmkpP3GshhV
 LnOz/DFXYMbVlv0TX3S4w==
UI-OutboundReport: notjunk:1;M01:P0:/FyPYwOqXO4=;suMn+VdIUS9vMvai+G+hHEjCTtK
 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
 BofBx9b7Dx+bzvrGByaQX5F52wY=
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/14/26 18:55, Matt Turner wrote:
> tuc_link is declared as 'struct target_ucontext *', which is a HOST
> pointer.  On a 64-bit host running a 32-bit SH4 target, this is 8 bytes
> instead of the 4 bytes the target expects, padding pushes tuc_mcontext
> 8 bytes past its correct offset.
>=20
> When a signal handler receives ucontext_t *, every field accessed throug=
h
> uc_mcontext (gregs[], pc, pr, ...) is read from the wrong address.  In
> particular the saved PC comes back as a garbage stack value, which break=
s
> any code that initialises a libunwind cursor from the signal context.
>=20
> Fix it by using abi_ulong, which is always sized to the target ABI (4
> bytes for SH4), matching the layout the kernel and glibc agree on.  This
> is the same pattern used by arm/signal.c.
>=20
> Also remove the (unsigned long *) cast from the __put_user that zeros
> tuc_link.  The cast was harmless when tuc_link was pointer-sized (8
> bytes matching unsigned long on a 64-bit host), but after the type
> change __put_user's sizeof dispatch would select stq_le_p (8-byte write)
> for a now-4-byte field, silently overwriting the start of tuc_stack.
>=20
> Neither this fix nor the companion setup_sigtramp fix is independently
> sufficient: this fix corrects register values read from the signal conte=
xt
> but libunwind still cannot detect the frame without the correct trampoli=
ne
> pattern; that fix makes the frame detectable but register reads remain
> garbage without the correct ucontext layout.  Together they fix the
> following libunwind tests on a 64-bit host:
>    Gtest-sig-context, Gtest-trace, Ltest-init-local-signal,
>    Ltest-sig-context, Ltest-trace
>=20
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> Cc: qemu-stable@nongnu.org
> ---
>   linux-user/sh4/signal.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

patch series applied to linux-user-next git tree.

Thanks!
Helge

