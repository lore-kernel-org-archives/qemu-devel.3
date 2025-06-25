Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 682A6C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 15:42:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUSGE-0003vT-HV; Wed, 25 Jun 2025 11:42:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uUSGA-0003v1-AC
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 11:42:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uUSG6-0002cO-5i
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 11:42:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750866115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=CD9jbQlASpMo4p7WtGdW5QE1GhuTo12aUBgBWAl8fO0=;
 b=AxQCZppAQh3OWkYJ+xGHIswdtqDw17oXOetnGjsrVANIyC/PYSD7zF/dTe68ASQ69dle7s
 odScTcpoopynrqXBBM9A5rWJw0TQPwi0iQvaHYIrya7MMpQoFaMjCkZj7C4zHKlKNkZu4D
 NB+MvEc6gm7PVGavJUL7RkKWtHAAYis=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-35bg_r8gOfu5_HQB0nw_Vg-1; Wed, 25 Jun 2025 11:41:53 -0400
X-MC-Unique: 35bg_r8gOfu5_HQB0nw_Vg-1
X-Mimecast-MFC-AGG-ID: 35bg_r8gOfu5_HQB0nw_Vg_1750866112
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-606f504f228so5330251a12.3
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 08:41:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750866112; x=1751470912;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CD9jbQlASpMo4p7WtGdW5QE1GhuTo12aUBgBWAl8fO0=;
 b=ZlTwiuEh0Q+3BjGiIPQAruIYWd4QN26xECLUUNVOw38u0HQtL492AxL6XrNUhNs1Ns
 Q30/TH9FxgWxWMWBAEGtA3jURVjSoX5i15wO5XPVLhg9MINOfwWQpVoSmu6iVvDYRd9G
 ppvCsMlPNsurpgNJaDA4U9shLGmdYC0Yk1RVgI/5/wd7NkcZoqfi2/8qX+im6wS3fNsk
 Ec+PgJcgCf4aSokwlauvH3BB9t4pH8CE+ir8VGkhZR6jdVsV6DlF35p9T5m97/7BH6k7
 G5fRn3C6yvs7muezHlVEww9OXrJ15Mwn2xVozJHop7mBVswUFZXUrGWSyLbIelpHuvZS
 w+lg==
X-Gm-Message-State: AOJu0YwJdJEvRxD+rtFlMKGfdhK2bbG7jZe86EASWCQd9YrUNEKnbs6m
 YNPbwTvToAR8TUte1DXQh0FabY8pnDzXgt2ecGScPacYJexegccwLtC58Zgg/t/72PjAJ0fvDQ5
 LTUymAxcFv3M41TkeFvKo7KYOS7btHf3fAUVZhHIk4fHR9XghxhRUVd+Xw0pQkFBYFKPvLgAiSI
 zn1w61GhmnGorH3Ca5pZnf7prDbYD5DcidQ5NB
X-Gm-Gg: ASbGncup0wqAVxwiLgvq+hvclAV6KRzIc0uI/igFiQ+wRpDl6RHKjhThgR7IkgmXY1A
 eqcAVsCZJKC1UDEsQrsrT91uAyFrUHxGFTHh1LEyCFsZRsARQem3up08TJWtJEjDztzM7z2PHtN
 /pNHwXAfH4GPlZ7F8Dp7LoAeR0lDgYjo1Z67jSHNyaeScGEvhBfhjBwCM31f4MJKLpLtUHlvXfi
 0jCeB0BrJwerAtT/oa9eCoVlsfj60hN6ERyN0KgplPwOFDUjJ4twvaki98oOnFKXFX6i0+F8p1g
 Z7InqOuN0aDR0FRPxhfI45PqkivDw+kwYPujVtFo6Lqr80oCh8miECZ91yOeuHo=
X-Received: by 2002:a05:6402:350d:b0:60c:3cca:651a with SMTP id
 4fb4d7f45d1cf-60c4debd454mr3048306a12.33.1750866111962; 
 Wed, 25 Jun 2025 08:41:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMhKUd2N5hEp5Q8eH+8tOKVsCiRfvuRVbaWTH2jFZyikWFcCD6Kltj9eAY0k2F1UrJf0WPJQ==
X-Received: by 2002:a05:6402:350d:b0:60c:3cca:651a with SMTP id
 4fb4d7f45d1cf-60c4debd454mr3048269a12.33.1750866111482; 
 Wed, 25 Jun 2025 08:41:51 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-115-198.pools.arcor-ip.net.
 [47.64.115.198]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60c2f46888dsm2729508a12.43.2025.06.25.08.41.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 08:41:50 -0700 (PDT)
Message-ID: <b3b5bd3a-1040-4aeb-8a07-e9e771a9e503@redhat.com>
Date: Wed, 25 Jun 2025 17:41:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] COPYING: replace FSF postal address with licenses
 URL
To: qemu-devel@nongnu.org
References: <20250613.qemu.patch@sean.taipei>
 <20250613.qemu.patch.01@sean.taipei>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250613.qemu.patch.01@sean.taipei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 13/06/2025 18.33, Sean Wei wrote:
> The license text in COPYING (GPLv2), COPYING.LIB (LGPLv2.1),
> and the linux-headers/LICENSES/preferred/GPL-2.0 file are
> referenced to the obsolete FSF postal address.
> 
> Replace it with the canonical GNU licenses URL recommended by the FSF:
> https://www.gnu.org/licenses/
> 
> Signed-off-by: Sean Wei <me@sean.taipei>
> ---
>   COPYING                                  | 5 ++---
>   COPYING.LIB                              | 5 ++---
>   linux-headers/LICENSES/preferred/GPL-2.0 | 5 ++---
>   3 files changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/COPYING b/COPYING
> index 00ccfbb628..8095135d50 100644
> --- a/COPYING
> +++ b/COPYING
> @@ -2,7 +2,7 @@
>   		       Version 2, June 1991
>   
>    Copyright (C) 1989, 1991 Free Software Foundation, Inc.,
> - 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + <https://fsf.org/>
>    Everyone is permitted to copy and distribute verbatim copies
>    of this license document, but changing it is not allowed.
>   
> @@ -304,8 +304,7 @@ the "copyright" line and a pointer to where the full notice is found.
>       GNU General Public License for more details.
>   
>       You should have received a copy of the GNU General Public License along
> -    with this program; if not, write to the Free Software Foundation, Inc.,
> -    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +    with this program; if not, see <https://www.gnu.org/licenses/>.
>   
>   Also add information on how to contact you by electronic and paper mail.
>   
> diff --git a/COPYING.LIB b/COPYING.LIB
> index 4362b49151..99f47575b5 100644
> --- a/COPYING.LIB
> +++ b/COPYING.LIB
> @@ -2,7 +2,7 @@
>                          Version 2.1, February 1999
>   
>    Copyright (C) 1991, 1999 Free Software Foundation, Inc.
> - 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
> + <https://fsf.org/>
>    Everyone is permitted to copy and distribute verbatim copies
>    of this license document, but changing it is not allowed.
>   
> @@ -484,8 +484,7 @@ convey the exclusion of warranty; and each file should have at least the
>       Lesser General Public License for more details.
>   
>       You should have received a copy of the GNU Lesser General Public
> -    License along with this library; if not, write to the Free Software
> -    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
> +    License along with this library; if not, see <https://www.gnu.org/licenses/>.
>   
>   Also add information on how to contact you by electronic and paper mail.
>   
> diff --git a/linux-headers/LICENSES/preferred/GPL-2.0 b/linux-headers/LICENSES/preferred/GPL-2.0
> index ff0812fd89..10248a619e 100644
> --- a/linux-headers/LICENSES/preferred/GPL-2.0
> +++ b/linux-headers/LICENSES/preferred/GPL-2.0

The files in linux-headers are sync'ed by the script 
scripts/update-linux-headers.sh ... so these changes will be reverted the 
next time someone runs the script. I'd suggest to drop this part of the 
patch - if you feel like contributing a patch to the Linux kernel, you could 
fix it there instead.

  Thomas


