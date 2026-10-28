Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C53606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 11:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=MGejUptv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM1rx-0005Sv-SH; Wed, 28 Oct 2026 07:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xM1rT-0005Nz-7Z; Wed, 28 Oct 2026 07:30:34 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xM1rQ-0003WK-Gi; Wed, 28 Oct 2026 07:30:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1793187024; bh=tNCub5uQRRuJTGutJAedxmxpnH8qHDzbOf7I7VtZ1ec=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=MGejUptvbN2rb2BXZOhjdGE6ksVc43qZvlbIGfSxlfgbqSOoeFw1vUd9MKTbLbCNA
 qS/TBjfMdSWuX/JyCi3NFPKGk6VCErvOuB/pcJrEAcsBNKD7dcnHJAWHRh/dV/jz4S
 /U9ez5wrdeyw1dhczCCqFuTMLLlwLjDk5S4FjAtm4PGuH/jIGjeDPVyZkH1CauuX1A
 vKzfsG8ofJr51VMvzBIBl1ujaVbjoGPuNBs5AlWnvjC+9ILQArOp8+HvCDOo8xc1Uj
 LW2i+ZUWHz6Bf8d4M2hoTVcV91bR7m22jj10xQrfyYoeMx7zavhTU+vCnxmzvxjwJ/
 XwZEs34gvtiUA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 231201E1E34;
 Wed, 28 Oct 2026 14:30:24 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0D4E044D6AC;
 Wed, 28 Oct 2026 14:30:24 +0300 (MSK)
Message-ID: <37c0e689-115a-42ba-bcfb-0993e1dbd2cc@tls.msk.ru>
Date: Wed, 28 Oct 2026 14:30:23 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] target/s390x: externalize feat dependency array
To: Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: Hendrik Brueckner <brueckner@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 qemu-stable@nongnu.org
References: <20261009185559.144750-1-walling@linux.ibm.com>
 <20261009185559.144750-2-walling@linux.ibm.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20261009185559.144750-2-walling@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/9/26 21:55, Collin Walling wrote:
> Move the feature dependency array (dep[][2]) from cpu_models.c to
> cpu_features.c, rename the array to s390_feat_deps, and externalize
> its length.
> 
> This will allow the array to be used between both files.
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
> ---
>   target/s390x/cpu_features.c | 126 ++++++++++++++++++++++++++++++++++
>   target/s390x/cpu_features.h |   4 ++
>   target/s390x/cpu_models.c   | 133 ++----------------------------------
>   3 files changed, 135 insertions(+), 128 deletions(-)
> 
> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
> index c634e741236..20f9947c7be 100644
> --- a/target/s390x/cpu_features.c
> +++ b/target/s390x/cpu_features.c
> @@ -223,6 +223,132 @@ void s390_feat_bitmap_to_ascii(const S390FeatBitmap features, void *opaque,
>       };
>   }
>   
> +const int s390_feat_deps[][2] = {
> +    { S390_FEAT_IPTE_RANGE, S390_FEAT_DAT_ENH },
...
> +    { S390_FEAT_SIE_ASTFLEIE2, S390_FEAT_STFLE },
> +};
>   static void check_consistency(const S390CPUModel *model)
>   {
> -    static int dep[][2] = {
> -        { S390_FEAT_IPTE_RANGE, S390_FEAT_DAT_ENH },
...
> -    };

This change moves whole dep[][2] array elsewhere.  When back-porting
it to the older qemu releases, there's always a merge conflict, because
some deps were added later and are not present in the earlier releases.

How these should be hanlded when back-porting?

For example:

  v11.1.0-588-g66deb271528 s390x/diag: Introduce DIAG 320 for Certificate Store Facility
    introduced { S390_FEAT_CERT_STORE, S390_FEAT_EXTENDED_LENGTH_SCCB },

  v11.1.0-602-gd6de77dab6e s390x: Guest support for Secure-IPL Facility
    introduced { S390_FEAT_SIPL, S390_FEAT_EXTENDED_LENGTH_SCCB },

and so on.

I guess I should take actual dep[][] arrray in check_consistency() from
the version I'm back-porting things to.

FWIW,

Thanks,

/mjt

