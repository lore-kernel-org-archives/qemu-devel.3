Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E41CF34D3
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 15:38:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLkFw-0004bU-Dw; Wed, 19 Nov 2025 10:38:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1vLkFu-0004b7-8e
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 10:38:02 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1vLkFs-0000Gf-EA
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 10:38:01 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0209243BF5;
 Wed, 19 Nov 2025 15:37:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E631C2BCB1;
 Wed, 19 Nov 2025 15:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1763566674;
 bh=ZlSa/qmvDSc9CepTXRRMIY0p3rqOSEmTCr5nD2ZZESQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=c34eWpTQk93KR+YpXGjX9jp/dqeFNUnMuUIh2znGXWZT5a87Iw0q9lHgy1ezj48mM
 RFHb69rJlFTOJcaPD+m01p7k83o/BT6cYzPchb+lCFjvj7JYTFTK/dW9+ZeWeHeOOA
 KV0PwkvoFzXSY2YMDl/1RQ3wwTPd8B1d89jHsBmP1G3aRgaPHLAen/KwI93+tYbu0I
 Va1f4qtK/eNuZG2Gg5H46LVwKHgWMmBaIPIxGg3Egs9j0lDdEsw/Rv+r84cg9XbcTO
 t3RlyUE618NpROKzE086Nn6KFB6uVsBTS7D3wZibXHlM+vl05K+A3fMkykV1qnYHHC
 M8Uy42ux4UOTw==
Date: Wed, 19 Nov 2025 15:37:52 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH 3/9] contrib/gitdm: add group-map for Microsoft
Message-ID: <20251119153752.GA2713040@liuwe-devbox-debian-v2.local>
References: <20251119113953.1432303-1-alex.bennee@linaro.org>
 <20251119113953.1432303-4-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251119113953.1432303-4-alex.bennee@linaro.org>
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=wei.liu@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Nov 19, 2025 at 11:39:46AM +0000, Alex Bennée wrote:
> While we do see contributions from the top-level domain we want to
> catch the linux.microsoft subdomain and those contributors also post
> via other addresses.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>

Acked-by: Wei Liu <wei.liu@kernel.org>

> ---
>  contrib/gitdm/group-map-microsoft | 8 ++++++++
>  gitdm.config                      | 1 +
>  2 files changed, 9 insertions(+)
>  create mode 100644 contrib/gitdm/group-map-microsoft
> 
> diff --git a/contrib/gitdm/group-map-microsoft b/contrib/gitdm/group-map-microsoft
> new file mode 100644
> index 00000000000..989a307b6db
> --- /dev/null
> +++ b/contrib/gitdm/group-map-microsoft
> @@ -0,0 +1,8 @@
> +#
> +# Some Microsoft contributors post from other emails
> +#
> +
> +# Some posting don't use the main domain
> +linux.microsoft.com
> +
> +wei.liu@kernel.org
> diff --git a/gitdm.config b/gitdm.config
> index 2d75dd4deee..8206c0af8a9 100644
> --- a/gitdm.config
> +++ b/gitdm.config
> @@ -39,6 +39,7 @@ GroupMap contrib/gitdm/group-map-facebook Facebook
>  GroupMap contrib/gitdm/group-map-huawei Huawei
>  GroupMap contrib/gitdm/group-map-ibm IBM
>  GroupMap contrib/gitdm/group-map-janustech Janus Technologies
> +GroupMap contrib/gitdm/group-map-microsoft Microsoft
>  GroupMap contrib/gitdm/group-map-netflix Netflix
>  GroupMap contrib/gitdm/group-map-redhat Red Hat
>  GroupMap contrib/gitdm/group-map-sifive SiFive
> -- 
> 2.47.3
> 

