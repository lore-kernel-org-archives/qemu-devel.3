Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6481710F286F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 21:32:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6Emb-0003rP-6s; Fri, 27 Mar 2026 17:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w6EmU-0003ob-5o
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 17:31:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w6EmS-0005QE-Az
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 17:31:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774647107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4ac1M9JC+VR0gKG13eSsUyzL1jccysJyAArRs9IH8XM=;
 b=Ys8TYb3dxfc6tZILmQ/EY4hT8CXSh/dOfQ/4OfVY/F6K80KKsbDO+L+hqRyspaPiK5xLZM
 WKonG5D71Ja7r7Oz2JlI510m0dszpIb4QCTol4k7+45C8FgO6u3lFEAK0Hq2h3BNC1YGQO
 t5vbv4KyZZtEtXS6mqgQP8NSsR3Dv9g=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-MuX1LMW-NR6juJDjKBH97A-1; Fri, 27 Mar 2026 17:31:44 -0400
X-MC-Unique: MuX1LMW-NR6juJDjKBH97A-1
X-Mimecast-MFC-AGG-ID: MuX1LMW-NR6juJDjKBH97A_1774647104
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5090bc4823cso62573091cf.3
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 14:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774647104; x=1775251904; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4ac1M9JC+VR0gKG13eSsUyzL1jccysJyAArRs9IH8XM=;
 b=LjxWtYderNLR10pUQOPuWULCqrMOqudow20jh6J2yWCmTty6ae9SzE6o0CcBf4qxp+
 UM9i5ZUXveQcZlcquuS47s7Mh4SheBCnkn9+loi77EUD9/r20wG8Ua2gfj9eKI3epaiY
 mUK3+IJrHDE1ecE7lvgxf5LQu1TkCHI/su4U91jjfmH7NNjygqiJN4JUaCy1QZ40rjI4
 0pNH61+W2o+9aHtaXvZLgY1LkqmrBKq63Pj1B610NY32Mu0uEuQjXsoryQCz+3JR8NgV
 3Z7GAVFNuV59vXgcmw4gV+AMyMnhLD1pF4WwUD0OzUx39nQTRCxJugcL5zVqTEI2VB4t
 LTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774647104; x=1775251904;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4ac1M9JC+VR0gKG13eSsUyzL1jccysJyAArRs9IH8XM=;
 b=UTHmIWUsRmLEJmVSl2yyvf8pKgAVx7xmNgFX0M3Hk7AXfM1BoUQZdYO3JhaJpy908n
 YezrDWvUETzO5eGK6RdM38s5P0RmcOgZXSydZEK3S4PpGVor8unFK/cfrKAtfim4EVtS
 DEGvMfGDC2GqsPcwXHZPqZmci1m8NlPzTzCvp530SHi6pSmqvAL2usF0DlMir1Xjv270
 IGML/gZ5aybMOC7PXmWssyPN/4dJaxHTzLYi8Ur25wugmTt83tK4EbgtlHkGmGHm60vV
 nGGHUmk89UBlGxVXTmToX+ZJSKRdIYqeX57ybLfMfrIShQOdOBGYm4oTL4IYx9eg3kSb
 aYvA==
X-Gm-Message-State: AOJu0Yw4IRo8RIwc1e7mAUQES6++dyY5VlnXfVthE7rENSJytEkEN9W0
 uBZDwZMDyKNXUklbxLLYIRMKO2Nk2e7VstEfEWzcMhr8s3+LKRANcYvcXoKLAOTXMGESnOje+8y
 5ufAcfoLIudSeoJ/+2dJydiMYFJC/Xm1RlXewVNOwLO5+qHOW6PqtBOfA
X-Gm-Gg: ATEYQzy319r880HH54k6rhO5Ojtbnx7/NBAswlpdrtm4vQRGD83v7SJuc8XXhPbxhYn
 glbItczLrJniOz7PMmeP5ahmW4zCnK1Z56ZCi5cs0h2Xwc+LvIiAnHWkTwLG9NRT3tobz8bnYia
 sU1IH6jmTIrnLcH085JY+Q9L4G71uKCAKf6LiH87pFUMMDvZ+29HGL8AT22q2i+4DzLBK37RCLe
 /lRois2Wq+2ZeUUPkX87joOQChH3jZpVCv5axMgZ+zThzlxZfJQ4mZo1OOToGGqaLDi3FSMmOYH
 T1HqNgcbL3CW/EjDoySCrxgnMvUFaNTyhs6lgCo5lnJAqzZhpANLaiK6gQA4OZjzNB5VUofHEXK
 0fbJGzmJXaWF1kw==
X-Received: by 2002:a05:620a:4890:b0:8c8:8126:7770 with SMTP id
 af79cd13be357-8d01c823116mr559868785a.67.1774647103700; 
 Fri, 27 Mar 2026 14:31:43 -0700 (PDT)
X-Received: by 2002:a05:620a:4890:b0:8c8:8126:7770 with SMTP id
 af79cd13be357-8d01c823116mr559863185a.67.1774647103108; 
 Fri, 27 Mar 2026 14:31:43 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d027edbfaesm31881985a.1.2026.03.27.14.31.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 14:31:42 -0700 (PDT)
Date: Fri, 27 Mar 2026 17:31:41 -0400
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Glenn Miles <milesg@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Anton Johansson <anjo@rev.ng>
Subject: Re: [PATCH-for-11.1 04/10] migration: Remove unused target-specific
 macros
Message-ID: <acb3PYC05OnoHJXs@x1.local>
References: <20260325211728.89204-1-philmd@linaro.org>
 <20260325211728.89204-5-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260325211728.89204-5-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Mar 25, 2026 at 10:17:22PM +0100, Philippe Mathieu-Daudé wrote:
> Last use of VMSTATE_UINTTL_TEST() was removed in commit 445d3facffe
> ("ppc/spapr: remove deprecated machine pseries-2.7").
> 
> The following definitions were added in commit b6c4f71f508 ("Resurrect
> the safe part of r5274") but never used:
> 
>  - qemu_put_sbetl qemu_put_sbe64
>  - qemu_get_sbetl qemu_get_sbe64
>  - qemu_put_sbetls qemu_put_sbe64s
>  - qemu_get_sbetls qemu_get_sbe64s
> 
> Remove all as unused.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


