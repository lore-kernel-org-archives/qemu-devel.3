Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49AFBC369BD
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 11:57:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u51Nq-00023r-GD; Wed, 16 Apr 2025 07:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1u51NL-0001pv-T9; Wed, 16 Apr 2025 07:56:20 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1u51NI-000739-Ex; Wed, 16 Apr 2025 07:56:18 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D058B4E6033;
 Wed, 16 Apr 2025 13:56:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 8l-mtgXqr-oN; Wed, 16 Apr 2025 13:56:03 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E0DE14E6027; Wed, 16 Apr 2025 13:56:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DE66574577C;
 Wed, 16 Apr 2025 13:56:03 +0200 (CEST)
Date: Wed, 16 Apr 2025 13:56:03 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Kohei Tokunaga <ktokunaga.mail@gmail.com>
cc: qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Alexandre Iooss <erdnaxe@crans.org>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Pavel Pisa <pisa@cmp.felk.cvut.cz>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, 
 Vikram Garhwal <vikram.garhwal@bytedance.com>, 
 Jason Wang <jasowang@redhat.com>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?ISO-8859-15?Q?Daniel_P_=2E_Berrang=E9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Hildenbrand <david@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, 
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: Re: [PATCH 10/19] include/glib-compat.h: Poison g_list_sort and
 g_slist_sort
In-Reply-To: <f6e0e42ae3491564478929e412991c2a16ee3539.1744787186.git.ktokunaga.mail@gmail.com>
Message-ID: <263e4803-65d0-5a41-4031-99766b067915@eik.bme.hu>
References: <cover.1744787186.git.ktokunaga.mail@gmail.com>
 <f6e0e42ae3491564478929e412991c2a16ee3539.1744787186.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

On Wed, 16 Apr 2025, Kohei Tokunaga wrote:
> On emscripten, function pointer casts can cause function call
> failure. g_list_sort and g_slist_sort performs this internally so can't be
> used on Emscripten. Instead, g_list_sort_with_data and
> g_slist_sort_with_data should be used.
>
> Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
> ---
> include/glib-compat.h | 6 ++++++
> 1 file changed, 6 insertions(+)
>
> diff --git a/include/glib-compat.h b/include/glib-compat.h
> index 86be439ba0..e441b396ef 100644
> --- a/include/glib-compat.h
> +++ b/include/glib-compat.h
> @@ -36,6 +36,12 @@
> #include <pwd.h>
> #endif
>
> +/* These functions perform function pointer casts which can cause function call
> + * failure on Emscripten. Use g_slist_sort_with_data and g_list_sort_with_data
> + * insted of these functions.

Typo: instead

Regards,
BALATON Zoltan

> + */
> +#pragma GCC poison g_slist_sort g_list_sort
> +
> /*
>  * Note that because of the GLIB_VERSION_MAX_ALLOWED constant above, allowing
>  * use of functions from newer GLib via this compat header needs a little
>

