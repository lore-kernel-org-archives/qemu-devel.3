Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10119E77198
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 13:10:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV9LF-0001WI-B9; Tue, 07 Jan 2025 08:09:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1tV9LA-0001Uw-03
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 08:09:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1tV9L8-0007rR-JQ
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 08:09:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736255382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z8SneHPZ/4nHM9ZaX6sBF34bISNBdtryM7dYGYHywh4=;
 b=V/NONbBx7EB7Zg6UCyrVaT+Ps4Ps4D3ksopu7ow/DLfEAYIgSrw1Q1yvC51sBLBIZuppny
 bZYDUjG/o9ZlczGi2iHzyhbVgije34lbSIAkSHitkwelWE1roiY2H2HFQ+aRvKS1BiNzdX
 Kf7ma8Dusw6BYomwkBJ/SATjjd7qDXk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-6AnHrDddPkiMRitk7crwvg-1; Tue, 07 Jan 2025 08:09:40 -0500
X-MC-Unique: 6AnHrDddPkiMRitk7crwvg-1
X-Mimecast-MFC-AGG-ID: 6AnHrDddPkiMRitk7crwvg
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4359eb032c9so122310095e9.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 05:09:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736255379; x=1736860179;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z8SneHPZ/4nHM9ZaX6sBF34bISNBdtryM7dYGYHywh4=;
 b=d+fmtIgfyhKfxMpTr5PAYpkKSOYF0QTcYGwmHaBIgi0JT9MOCI6A/QZabeoLr1Typl
 j+B/Fyw7hWCLdsTtUYhfOHCFupzEWAUBtobFHj6Ny9DVfM9TWV3r70GO7DyA2qi0C97C
 rnVIHkvE0IzPjYK0D2zIMWfqD93F26yq5Sne5aD6r5EZg79LpzHiwAImc5zd47015E6m
 TXzRs/0XvNGcE4CFhX1SafJi0BcP5alDJmDVY7wDCQsl9/VOnUhHwYdAgZ77PIhG+Wrx
 XlQjuzfVRgLIKerAhzZjx5abSMozjcJG3QpFBYmTe2IDwzuqsWJ+4Wnvp73PZevgpgJI
 IVOg==
X-Gm-Message-State: AOJu0Yy3CHzRrxW+2sv9uG88MwLc7KSjUd6lc/KJW3bKbw4hLKuMijHu
 zIPSYCAmowtrs6wObN4xnPdufzZe5PhuGjb15o21OxC18T6QqOKg/YeK9bOzpE0Ygsf9KLkAN54
 uBns9+ps5NxM8YdcBIR6E5siy6sWOHZcWcN0t/mlEntn2djnlkZ/b
X-Gm-Gg: ASbGncsNOgllU7ecsFaB57zW2CHNslKiGLuZCa8hKR8wd7q2DTICfGSpPYe6NHx6jcK
 v++26kQd1KOa+nv1eUfT3tshmeknPOoM2Q+btELfLvptQoiGvvg/yy2AjFRpwj83b8oYk8XD6qk
 arxQUZ5pfFPDdK0mDCAxDuLU9ILcmUzEDNvGb/AggvTnbINEMGwbeLxGhxZgIh8WIlDBp0wF0sv
 thcXVvp5EKVKG1oCK6zQ9AZRaZxQh6sfkyBCEogfTEPiSokMMzywl8Xlm/rRGm/B8U5JHoMDLY+
 IMduXno=
X-Received: by 2002:a05:600c:4f09:b0:431:12a8:7f1a with SMTP id
 5b1f17b1804b1-43668645d57mr547972915e9.16.1736255379577; 
 Tue, 07 Jan 2025 05:09:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhcA+WlPqoUl38UGeEmWIPlI66PSxJ0Rfsc4UYZdAE5OaQC92/hHXEpr5BEYqrnqqTlF4Bkg==
X-Received: by 2002:a05:600c:4f09:b0:431:12a8:7f1a with SMTP id
 5b1f17b1804b1-43668645d57mr547972625e9.16.1736255379210; 
 Tue, 07 Jan 2025 05:09:39 -0800 (PST)
Received: from [10.43.3.236] (nat-pool-brq-t.redhat.com. [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436dd11ddfdsm12348165e9.1.2025.01.07.05.09.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2025 05:09:38 -0800 (PST)
Message-ID: <794d89b6-45db-4d10-8a10-ed646859c044@redhat.com>
Date: Tue, 7 Jan 2025 14:09:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] qga: Make run_agent() and run_agent_once() return
 no value
To: Konstantin Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, jtomko@redhat.com
References: <cover.1733414906.git.mprivozn@redhat.com>
 <8f4469febaaf5c48afdf13a6c88e959956c0f204.1733414906.git.mprivozn@redhat.com>
 <CAPMcbCrLq5Q=1uVwhRDO8MgUekzcUXzbOvcg-CuibGNYyjceHw@mail.gmail.com>
 <CAPMcbCoibsbysQLj_LRmuJUZ=ZM2ATP03dbo5zWzPxyyFfycMA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>
In-Reply-To: <CAPMcbCoibsbysQLj_LRmuJUZ=ZM2ATP03dbo5zWzPxyyFfycMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 12/23/24 13:39, Konstantin Kostiuk wrote:
> Hi Michal,
> 
> Do you plan to fix this patch series?

Yes, but I got sidetracked just before leaving for Christmas. I'll post
another version soon.

Michal


