Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6942ECD993
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 18:08:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo3l0-0003uV-LV; Thu, 05 Feb 2026 13:07:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1vo3kz-0003uJ-6H
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 13:07:09 -0500
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1vo3kx-0000FO-Cc
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 13:07:08 -0500
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-8c6a50c17fdso122098285a.2
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 10:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1770314825; x=1770919625; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rk2ui5W3DnhExIsAfxXjEst1i/Wd+6s6ncrlpi4G+N8=;
 b=cla/lCkfUym4GzbNoOnucITlzyB5sHKAXtSEGZlfcGjcHvgDrk0qVNJ6pz8AfizjI6
 YyFy5Y0p/mhkBAH5VJzA3CqRkvIAYTts5z9Kga/Ky40SnJcAmeZcpjmwFpSrHNiEDt0u
 8WE8DqQoxB8Y1EJBWAkNW1nkZ1QZx9dupo6enJ/6zsUnKeYEafdyozG3JbkqBKBq2AJp
 UIgvKqJzi7826299ddsSKwRyHY7tCOZknoTUKK5GDpQhmbcHlI3cpW1/8BVNJULo1bFz
 5mqbh+PQOkNbDhSmnphnJjlhU+yMrVSoYADfLC8SmwcEIwmJBTnhRAdJrJI54Gor0R2+
 CxEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770314825; x=1770919625;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rk2ui5W3DnhExIsAfxXjEst1i/Wd+6s6ncrlpi4G+N8=;
 b=P4dCfE384b8U9kwQQem73RQ6o2/ed/RMDtRyNAi//pRmx2UTIrJtLMolRC5+Ena1bz
 QjF3X4okKO2JEp83htQaJbsoe6bD4fLQNiffMgSYxghcJrHH4yURIZ2o2P1+k7tiS9qq
 g2NufV4UKr+jG7EmlB4jraUebtk/EWBKACoJZZsZ3x+2lfUeHIEQPx8ev1B7LrUXY8lM
 6yUvkNSCgpolqMcZ1I0sKXfAeiedmRDajAf3XWdv+BMSKZDJIcglwFnkXSQ8T3M3XbyL
 DXhytrU827M3OppPiHQFin1UCsxi7tONMY13Le5ake2bxvg72xOLnBh2OAA1T1kCAYBx
 q9cg==
X-Gm-Message-State: AOJu0YxEd/hDO8SEYKItzsyfIH1tQF8l82vfy4RrHrca0Vf74c3703/T
 QEIcdWXdmoa7zn+GaLjOAmz9YhQtvDTmiZwHP0DlJy6jQ1bqu+kG4FAt5QzVLYkrw6I=
X-Gm-Gg: AZuq6aI8uDRl2ztn1A7eg16n2jCZW8EERzguiSr66lFO5ysAih8fkF4I7aH3OyFGbb2
 zYZ5xpp9F8Hl0acmyVvaR6s+eBKXd3/FHtWUnIfwye5+oVZtMGYZk6n/670eMGKuFbkJvxGyz9k
 hSnjeVkVvBvgStF319up/3Bi+APM+7lqrQ1rANEl4OfBXLYU/Rua1pTpNJ+r+Hq4hNA5/Cv42MS
 mAWYAzL15wiJMnTRLrtwiZcm44HsrKvgyr6hGKp/KobGypbLu+jCl1x/AGyeicl8JQ/4on9v+z3
 BDunyqWHOEy5A38aNOIZZkz2Nyjmb6FgEloNA8FhgdJUYDhaZkwcfs9+M/ayHzOtRVR/g/8Sp3B
 OOmme9Ifg+1rGTbK6SgAwIdsbI4OQII8MsK0tlbRy6HCa1BmmN/H0150HYovlAOC2QRFyEZENZU
 tC2Cs5VzhVvk1zJyH5rmIyADVC+8HNA8sUXYkc4cYmlx7JdseILW20WvuNwwRhWq15nmcFig==
X-Received: by 2002:a05:620a:1928:b0:8c6:893e:b38c with SMTP id
 af79cd13be357-8ca2f858198mr954380685a.22.1770314825424; 
 Thu, 05 Feb 2026 10:07:05 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F
 (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8ca2fd5686bsm447030785a.51.2026.02.05.10.07.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 10:07:04 -0800 (PST)
Date: Thu, 5 Feb 2026 13:07:03 -0500
From: Gregory Price <gourry@gourry.net>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: qemu-devel@nongnu.org, linuxarm@huawei.com, jonathan.cameron@huawei.com,
 nifan.cxl@gmail.com, anisa.su887@gmail.com, mst@redhat.com,
 armbru@redhat.com, lizhijian@fujitsu.com, ppbonzini@redhat.com,
 peterx@redhat.com, philmd@linaro.org, david@kernel.org,
 imammedo@redhat.com, xiaoguangrong.eric@gmail.com, venkataravis@micron.com
Subject: Re: [PATCH v2 0/2] Performant CXL type 3 non-interleaved regions
Message-ID: <aYTcR4mfYbCiewTI@gourry-fedora-PF4VCD3F>
References: <20260204150002.669-1-alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204150002.669-1-alireza.sanaee@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::735;
 envelope-from=gourry@gourry.net; helo=mail-qk1-x735.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Feb 04, 2026 at 02:59:59PM +0000, Alireza Sanaee via qemu development wrote:
> The CXL address to device decoding logic is complex because of the need
> to correctly decode fine grained interleave. The current implementation
> prevents use with KVM where executed instructions may reside in that
> memory and gives very slow performance even in TCG.
> 

what was the base-commit of this set? I'm having trouble trying to get
it applied.

~Gregory

