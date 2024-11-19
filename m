Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F016AD60D1E
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 05:05:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDGPl-0000A2-Eu; Tue, 19 Nov 2024 00:04:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tDGPe-00009l-DU; Tue, 19 Nov 2024 00:04:31 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tDGPc-0003Ga-V6; Tue, 19 Nov 2024 00:04:30 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7eab7622b61so342744a12.1; 
 Mon, 18 Nov 2024 21:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731992667; x=1732597467; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qqTxpqcAM2hqZdqtQHIGcD0C2B+XejWsv9JQ5yk5pig=;
 b=i78R4JXgggKJrgwnDt2F0kQbUKT4kQFJnBkRE3aypIbw3Z018ZMUn/3p6avTU1+VsW
 OX0tBlvoBGv7aFxfjHQlfAcmWfIx0RgTioE3xD+wYujndNd4Ec32H9bmF1orNYTGOP7o
 Oe+0ePyGpqC+q6tpolBL1HK0MxjUz14nEeiS+FwCva0Mp7COV083P8LqHYQ5vbGC7OR6
 ch/Ywlyl+thjsan0/jYBHE+bC3yqCTOkLulgt1aeR+uwcmxHF6cN79DZA86xz6qd2zGm
 LaFxBqG4BTut/W6UyxZWwL9EAC5nn5OJL176Wceinrdor7WuSymtrgSwnX6vSrBTd/Yr
 IYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731992667; x=1732597467;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qqTxpqcAM2hqZdqtQHIGcD0C2B+XejWsv9JQ5yk5pig=;
 b=mMHa37bn0yiYmUzHMtt+ZBybbuT8GWjQ+yN11ErWqY7O5FhDuyVG8HSarBxtZticWq
 1FeG7N1MTEUQ9YwtG4DP4xZ2d67aTRTz4A/3KWJxx67WtJOJSMWAKVUItFLWbOGNPAlN
 NF3M/G3Of05wpk/jp7Reg/0qKLvn469oAkIJDglAmWVLGMM3C7c21rxTqmDr1ZcLZwhu
 VF5SoXfc8BLgvvoTSd7znT+EH3ObX4u25f+tYxH6gjbhyuI+2zPXzmQjhRMevUlrFW8U
 9max3uIWsSkPe79z1QyktCxg8d/HcmcNKr+hGWEXJVZt/yOgZQ7/tRev8DppGe3kydyi
 Agug==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkhWnhWJVokJqWVg9K7cVVO5EHB97UyTbvIY/3khF7lHwUsQce/67dCqHKX5ma+H+Ackkq9Y0p+kuF@nongnu.org
X-Gm-Message-State: AOJu0YyjleysszWUXTzaj1XJAqYUExZZ3TQZdvRnnCeHI7zwXMuU2xoF
 au3M+0L1Vc6lF1VvK4PVggW6K32NZtZkyjOJkuRbMhK/6VYDAXgP
X-Google-Smtp-Source: AGHT+IGg0mGmnHHznBdPV2/F0u2svyQbEOW34qSaRD81FJlUPfOtS8JAxoQSQul6P5c6n+uu6crqQQ==
X-Received: by 2002:a05:6a20:7f92:b0:1db:f53d:f0c2 with SMTP id
 adf61e73a8af0-1dc90c0502cmr21251831637.43.1731992667057; 
 Mon, 18 Nov 2024 21:04:27 -0800 (PST)
Received: from localhost (124-171-72-210.tpgi.com.au. [124.171.72.210])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea81b25e9dsm2479515a91.41.2024.11.18.21.04.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2024 21:04:26 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 Nov 2024 15:04:19 +1000
Message-Id: <D5PW5NDBCB50.HQFJEDVDYV2V@gmail.com>
Subject: Re: [PATCH 13/14] pnv/xive: Fix problem with treating NVGC as a NVP
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Michael Kowal" <kowal@linux.ibm.com>, <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, <clg@kaod.org>, <fbarrat@linux.ibm.com>,
 <milesg@linux.ibm.com>, <danielhb413@gmail.com>,
 <david@gibson.dropbear.id.au>, <harshpb@linux.ibm.com>, <thuth@redhat.com>,
 <lvivier@redhat.com>, <pbonzini@redhat.com>
X-Mailer: aerc 0.18.2
References: <20241015211329.21113-1-kowal@linux.ibm.com>
 <20241015211329.21113-14-kowal@linux.ibm.com>
In-Reply-To: <20241015211329.21113-14-kowal@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed Oct 16, 2024 at 7:13 AM AEST, Michael Kowal wrote:
> From: Glenn Miles <milesg@linux.ibm.com>
>
> When booting with PHYP, the blk/index for a NVGC was being
> mistakenly treated as the blk/index for a NVP.  Renamed
> nvp_blk/nvp_idx throughout the code to nvx_blk/nvx_idx to prevent
> confusion in the future and now we delay loading the NVP until
> the point where we know that the block and index actually point to
> a NVP.
>
> Suggested-by: Michael Kowal <kowal@us.ibm.com>
> Fixes: 6d4c4f70262 ("ppc/xive2: Support crowd-matching when looking for t=
arget")

Mechanical renaming should be moved to the start of the series,
and the fix should be merged into patch 3. Commit tags should only
be used if they exist in upstream repo.

Thanks,
Nick

