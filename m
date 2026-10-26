Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25A160A2628
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 16:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Go/cn14j
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLNJ1-0005Pe-8m; Mon, 26 Oct 2026 12:12:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xLNIy-0005PG-1O
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 12:12:12 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xLNIw-00080E-Ge
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 12:12:11 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-8ab38a051aaso29447867b3.3
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 09:12:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793031129; cv=none;
 d=google.com; s=arc-20260327;
 b=jVzcKP/opo8N8L6MIaQ/CyDom8CFAs1jfgijnMnzjx81H+o5/KQNQ0H2KXQzg9hxM5
 YjBYDvNOmt99+xtkJUKxVE0/zczDZDXKvybHYq1s97aIEhYelx1+wNh1oqMK7WQ6b6vB
 Vy3bQIOJs8bIc1KGbc71uSBspkdk4ZV06lMlZyj7z7Goz+4a3GcuG+wr/vEZ2U2rAhVy
 IdPvmNP5XrkB6eyUvWSIKFsY1lDchgm4YnmwpcoWzc8ZGZoPjPU0Ux2bUxIHMFDahQWD
 /c1hjEJ3VZw3/wPlYE7BjGkrpyJE24mMRTVLLJtqkpuuFQWk/9TxmpVHwKm+ruH71Ieb
 mFuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=nDYk4R6OzToVW8LryVb0Qb+7Vtwsxdln08yIOV1b8ng=;
 fh=p94jMzLCDBtRBUSOZ2t+Jbjd8bwENb4zRiEUN7ZbJAM=;
 b=NQ0aMxVlYxpLeWmk61JAvlaZQMsW+ie/fJ+6BL+bpukOzSZtOkev/fAst0r5vpgyYr
 Hlo9Nj5IeWvlhZ/scVJcMFgFnrMDkG9Oi9AFnI+bGl8k/h9txucfw9J0NImvOvR3D4Dj
 kmXM+xDgutk+DNcMJflotynb+kf39sKKoj1WGratCARDkXLetI9RNo7dgrvB+id3z8tr
 o1XEiMdga+AtkaH0GDjKRC153xYubisrAxf7BszNBnNy2g0wVjJI2Lj8glvy+p+Gkrx7
 MdRmF9h4kWoPj/S73c/uKaw+q9NC919zNxaxaVJBTnsrgXuErWs4ZH+ckFGqb9y0t2dg
 7KMA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793031129; x=1793635929; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nDYk4R6OzToVW8LryVb0Qb+7Vtwsxdln08yIOV1b8ng=;
 b=Go/cn14jvvAgHQXQKfnPsvodMxQ3afr3iSeXORefustiao8CQwDLvzGvEcSErRnxCm
 8nnFz/uvFTtS1Wpr9I527ieETYAzx/PUbWgdmUwyX//Alhw/UFuVYqYk+St1FwqJ8tTJ
 bvvxmdannGimpRG9H1Zbo4r2lXRLj9nUnT0tn+h0a9HTMtOzcSeVcqm/RrBhyodZ5Dlj
 6e9r8bg8b2h07ZMmgeajOPfyT6yA5Zuy+xTMBnFsKcd4bJ3hlDq60FUDBeFaTGf8hD6H
 3+DU4sfeG23HfK1Fe5kjqOsjuqap6hfIbvuGehJP8K24dj1KIMj4V3SEE7J/YJ4aw+NF
 4Wmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793031129; x=1793635929;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nDYk4R6OzToVW8LryVb0Qb+7Vtwsxdln08yIOV1b8ng=;
 b=JPoJeCUOwsuejI7VsxYokTNDsTuJn7xTrwuh+CR8ZcgDSLtkX7FIXgt24s4yOWO34p
 sFbJDYhOotu6SdZ03K+84lHqUynVKn1IH2+5NekB33bqmCbpzGAMzlptEtaIn5c+LD1S
 Ljo2uLJr/CRx57cBQc7FqwZg13zgP12p6s8tSqNjFMPafe0GgoaZeVh5ETSnbsjndUlR
 Uhagbo8/TWigNJxJcRg78wMak7vdL4C5dU5cMThFL58Otm7UYscxqzG2z+DLvA9lGKWL
 4EnVutB1WcZhIj+Jc930BqZaQpuvQH8ah+3Atm1Gast/l5QBKD03GpVWju5yWJrYF28R
 O08A==
X-Gm-Message-State: AFq9FYLjGJw4FwuY5jj+NnsNM9pzKK0MkjgVwlKWr3kEnkwlbRp7R89/
 fosuHTy+/F09FXDxY7iSoqIkukjvjsiHkbgM2xALkDgFoVXi4wQ4EsZu78W4lB/wdBQk8uu3HMP
 U7xOvuB5qJR24DFoMrCLwd3qJW+hhaN5x8WHlueL+wF1y6RVYHerOvcjYKw==
X-Gm-Gg: AYBFou1NNFPfecUF8OJojRQhkM6/ghwbsG1yaTt8gEYeWQ/bxFlgCCn7bO7cAvcI33q
 MrRLsSJJ3mz54ZfOlNB4zaPni7KhPat8SW15gbL1NVt5XQG69bEc/KNqnPDoBnqWLVPhx274Bnn
 Zw4f3Bq3Q/i9mwEj1kmCCuXLg8RTcpXumDisXRHU9Ho1MWKDvvkAVLFAAK4UIklI28Gd4XLgq7K
 ZOjzBQ8WHSPARNQ1oWlxvwHO0ffl6QIzmRx6cH4HhMj5honjP350ji1F1C+hCbeiQXVP7is+xnh
 UQWElSLteEPwivy9ro7rn2xMPhGOF9dXWHjhXtvfn2t2FoLxAHPr3djX8rAI7KN8Hz7Njf1iTDY
 vXUiKnc5VwEpE8ju2/2VNJVKoBaKTs9KIuXboEXTYwMLNIiEajEnX3Rg5Ip+UafVCIBckdw/Alj
 QgmA3G2COx8hvM//qhjGrY
X-Received: by 2002:a05:690c:e1d9:10b0:873:5c7b:c0ef with SMTP id
 00721157ae682-8b166c2ba0amr35291277b3.39.1793031128955; Mon, 26 Oct 2026
 09:12:08 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Oct 2026 16:11:57 +0000
X-Gm-Features: AclHuK_1aiOvUv0ppmkecWE1EMWc6dbC0yylbEIXN1V1qLzrnAbsbjfUTMdgwXw
Message-ID: <CAFEAcA_1ESA4Uan=gJyiRrjj4-EVvtfgn2dUT8qDa8zUU_gf=g@mail.gmail.com>
Subject: migration, PCIE ports, and parent_obj.parent_obj.parent_obj
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In reviewing a new pcie host bridge, I noticed (because this new device
copied existing code) that the vmstate structs for pcie root ports do
this in their vmstate structs:

    .fields = (const VMStateField[]) {
        VMSTATE_PCI_DEVICE(parent_obj.parent_obj.parent_obj, PCIESlot),
        VMSTATE_STRUCT(parent_obj.parent_obj.parent_obj.exp.aer_log,
                       PCIESlot, 0, vmstate_pcie_aer_log, PCIEAERLog),
        VMSTATE_MSIX(parent_obj.parent_obj.parent_obj.parent_obj,
                     GenPCIERootPort),
        VMSTATE_END_OF_LIST()
    }

(this specific example is hw/pci-bridge/gen_pcie_root_port.c).

Devices shouldn't have to have ugly long chains of "parent_obj"
like this and shouldn't have to care what in their parents needs
migration; compare e.g. SCSI devices, which start with a
"VMSTATE_SCSI_DEVICE" that captures all the parent class's needs,
followed by only the state that the child added.

How can we get to something more like that for PCIE port classes?

thanks
-- PMM

