Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 007F9E81A25
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 15:06:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs0AW-0003yc-HJ; Mon, 16 Feb 2026 10:05:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vs0AS-0003y2-Ox
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 10:05:46 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vs0AN-00087D-3x
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 10:05:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=Jqvt2xtW/YJBuKlgzvS9GEOhA5DV1ZuK8uIR3sVU2yY=; b=WB8HgcqB//nXm3n
 HjyT+nvhdY92bac0s9JnGPnQj0NLkigC+J76+WkvxHRRorrTyMUlJtsQ5fnp1zGyFhNWTUoFKZPLt
 WrIhfI5qybf7Z9vVekUxqZSmg9vNHQXjmE0/8eEU/LXLCEFYUvS6Y8gbScrJDYVmuQqmFtJ+RS38K
 28=;
Date: Mon, 16 Feb 2026 16:09:09 +0100
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com, 
 matheus.bernardino@oss.qualcomm.com, sid.manning@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, 
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng
Subject: Re: [PATCH v2 2/8] Hexagon (linux-user/hexagon) Identify Hexagon
 version in ELF file
Message-ID: <aZMy2j7pxhNePNl_@hive.localdomain>
References: <20260215220422.212249-1-ltaylorsimpson@gmail.com>
 <20260215220422.212249-3-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260215220422.212249-3-ltaylorsimpson@gmail.com>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 15/02/26, Taylor Simpson wrote:
> Return proper Hexagon CPU version from get_elf_cpu_model
> 
> Co-authored-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> Co-authored-by: Brian Cain <brian.cain@oss.qualcomm.com>
> Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---
>  linux-user/hexagon/elfload.c | 43 ++++++++++++++++++++++--------------
>  1 file changed, 26 insertions(+), 17 deletions(-)
> 
> diff --git a/linux-user/hexagon/elfload.c b/linux-user/hexagon/elfload.c
> index d8b545032a..39b0201814 100644
> --- a/linux-user/hexagon/elfload.c
> +++ b/linux-user/hexagon/elfload.c
> @@ -10,23 +10,32 @@ const char *get_elf_cpu_model(uint32_t eflags)
>      static char buf[32];
>      int err;
>  
> -    /* For now, treat anything newer than v5 as a v73 */
> -    /* FIXME - Disable instructions that are newer than the specified arch */
> -    if (eflags == 0x04 ||    /* v5  */
> -        eflags == 0x05 ||    /* v55 */
> -        eflags == 0x60 ||    /* v60 */
> -        eflags == 0x61 ||    /* v61 */
> -        eflags == 0x62 ||    /* v62 */
> -        eflags == 0x65 ||    /* v65 */
> -        eflags == 0x66 ||    /* v66 */
> -        eflags == 0x67 ||    /* v67 */
> -        eflags == 0x8067 ||  /* v67t */
> -        eflags == 0x68 ||    /* v68 */
> -        eflags == 0x69 ||    /* v69 */
> -        eflags == 0x71 ||    /* v71 */
> -        eflags == 0x8071 ||  /* v71t */
> -        eflags == 0x73       /* v73 */
> -       ) {
> +    switch (eflags) {
> +    case 0x04:
> +        return "v5";
> +    case 0x05:
> +        return "v55";
> +    case 0x60:
> +        return "v60";
> +    case 0x61:
> +        return "v61";
> +    case 0x62:
> +        return "v62";
> +    case 0x65:
> +        return "v65";
> +    case 0x66:
> +        return "v66";
> +    case 0x67:
> +    case 0x8067:        /* v67t */
> +        return "v67";
> +    case 0x68:
> +        return "v68";
> +    case 0x69:
> +        return "v69";
> +    case 0x71:
> +    case 0x8071:        /* v71t */
> +        return "v71";
> +    case 0x73:
>          return "v73";
>      }

Hmm could we not add v67t/v71t to HexagonVersion and use the enums here?

-- 
Anton Johansson
rev.ng Labs Srl.

