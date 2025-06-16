Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20DFAC71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 19:00:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRF3h-0000pz-TL; Mon, 16 Jun 2025 14:59:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uRF3d-0000pZ-Lk
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 14:59:51 -0400
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uRF3b-0000nA-Rx
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 14:59:49 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id D9391A51E22;
 Mon, 16 Jun 2025 18:59:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606AAC4CEEA;
 Mon, 16 Jun 2025 18:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1750100384;
 bh=M38YybNg95iwMHGdSjlLs0pglry1aQaEHlBsaf3QXPY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DdsK/7UGhPIH4nLVst6qwnmLQHGgPJ1b2sn6z3HolCwa8OupGrICtQdMP3VFa7gQK
 OVOQITg5z+/6gJUOym2757EcdauLcnoHjCqnc8EGntqWLcZFQwUDkK2uXwut9ot4sb
 zFtM+IngNiS9WgByNZtis1Hc2nxmUrFdwPzmBIxacYcuB3Pg0Co/D+HV89IN2Yk0ws
 fPXVGVKTTu4OCB/912etwfhtIprfgv8jWdqpARvp4b/CHtS6MJHurflMiQdVWhavoW
 zP+mZIyaFY/Ee6QBQjT9BrMD/0kBemVuvP8iuA6CdMD2fXs74evDfQrCBh0nIJxWTC
 BNmyFhKUNjX1w==
Date: Mon, 16 Jun 2025 18:59:43 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Sean Wei <me@sean.taipei>
Cc: qemu-devel@nongnu.org, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH 12/12] target/i386/emulate: replace FSF postal address
 with licenses URL
Message-ID: <aFBpn7aeZfGJMZ-8@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <20250613.qemu.patch@sean.taipei>
 <20250613.qemu.patch.12@sean.taipei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613.qemu.patch.12@sean.taipei>
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=wei.liu@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.892,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, Jun 13, 2025 at 12:54:20PM -0400, Sean Wei wrote:
> Some of the LGPLv2.1 boiler-plate still contained the
> obsolete "51 Franklin Street" postal address.
> 
> Replace it with the canonical GNU licenses URL recommended by the FSF:
> https://www.gnu.org/licenses/
> 
> Signed-off-by: Sean Wei <me@sean.taipei>

It looks to me this is just following the footsteps of commit 8167ee883.

Reviewed-by: Wei Liu <wei.liu@kernel.org>

> ---
>  target/i386/emulate/x86_emu.c   | 4 ++--
>  target/i386/emulate/x86_flags.c | 4 ++--
>  target/i386/emulate/x86_flags.h | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/target/i386/emulate/x86_emu.c b/target/i386/emulate/x86_emu.c
> index 4890e0a4e5..db7a7f7437 100644
> --- a/target/i386/emulate/x86_emu.c
> +++ b/target/i386/emulate/x86_emu.c
> @@ -31,8 +31,8 @@
>  //  Lesser General Public License for more details.
>  //
>  //  You should have received a copy of the GNU Lesser General Public
> -//  License along with this library; if not, write to the Free Software
> -//  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA B 02110-1301 USA
> +//  License along with this library; if not, see
> +//  <https://www.gnu.org/licenses/>.
>  /////////////////////////////////////////////////////////////////////////
>  
>  #include "qemu/osdep.h"
> diff --git a/target/i386/emulate/x86_flags.c b/target/i386/emulate/x86_flags.c
> index cc138c7749..6592193b5e 100644
> --- a/target/i386/emulate/x86_flags.c
> +++ b/target/i386/emulate/x86_flags.c
> @@ -14,8 +14,8 @@
>  //  Lesser General Public License for more details.
>  //
>  //  You should have received a copy of the GNU Lesser General Public
> -//  License along with this library; if not, write to the Free Software
> -//  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA B 02110-1301 USA
> +//  License along with this library; if not, see
> +//  <https://www.gnu.org/licenses/>.
>  /////////////////////////////////////////////////////////////////////////
>  /*
>   * flags functions
> diff --git a/target/i386/emulate/x86_flags.h b/target/i386/emulate/x86_flags.h
> index 28b008e577..a395c837a0 100644
> --- a/target/i386/emulate/x86_flags.h
> +++ b/target/i386/emulate/x86_flags.h
> @@ -14,8 +14,8 @@
>  //  Lesser General Public License for more details.
>  //
>  //  You should have received a copy of the GNU Lesser General Public
> -//  License along with this library; if not, write to the Free Software
> -//  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA B 02110-1301 USA
> +//  License along with this library; if not, see
> +//  <https://www.gnu.org/licenses/>.
>  /////////////////////////////////////////////////////////////////////////
>  /*
>   * x86 eflags functions
> -- 
> 2.49.0
> 

