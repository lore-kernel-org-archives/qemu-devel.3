Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 815BDC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 14:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woLvt-0007D0-PW; Mon, 27 Jul 2026 10:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1woLvs-0007BU-GS
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 10:03:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1woLvr-0007AS-64
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 10:03:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785161030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/uedi/+XUPUkKbp4YXNJFI9jLAVF08Vs22jhPQ6R5tQ=;
 b=dv3yglo3XPzERT7SwBWFdKkobzfaUbozmaegMnPkwzmaX1n74XtuGoTG+qvm+RfCqSzwUt
 3dyze0ojIFCpGNg6qsTBphii+1/TzuRVgV1RIwKHk9ldJL3LgAhSRsIOuajrJ+GDBkqPev
 ggA405fGnLvZOpgPngf9ECEHDuT/ip0=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-PNZ_xPqzO3mc6Jt5Ob5Flg-1; Mon, 27 Jul 2026 10:03:46 -0400
X-MC-Unique: PNZ_xPqzO3mc6Jt5Ob5Flg-1
X-Mimecast-MFC-AGG-ID: PNZ_xPqzO3mc6Jt5Ob5Flg_1785161026
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-976cb36b375so308065241.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 07:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785161026; x=1785765826; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/uedi/+XUPUkKbp4YXNJFI9jLAVF08Vs22jhPQ6R5tQ=;
 b=qhMcNVbYFY4PLy2Yn0qcl6pNyW1GQussgb3JCKLu7cHszgPx5/UpSjUOFbIfF4G/43
 ERiDSKM2wV7BnYvXhF0GRDL03y5SNJz4E6c/B5wTWjeas6uM8yz14nZHgNPW9KjJbehs
 OK92H7r7DLG8dYAZCLzO12kopaaw8Z4Iml3dQumrnjTiDaJI8nkRc4gdOJGn87iKMtTC
 ZNe91WPua+Ucgs5irKpRCTpnNVcodnaUNDeg8xXM20/K0PCmBzwbO1Sap8FF8lDHa4Uj
 GBs8um0O/1yMOluiTtayHk+lGy1JGPlnJ0a1G/GCMypWYfnmqjpH9/VrHeYczmyc/hmD
 pRiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785161026; x=1785765826;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/uedi/+XUPUkKbp4YXNJFI9jLAVF08Vs22jhPQ6R5tQ=;
 b=eCWYPz7oLsCAmbGmcF7vmEa7cy+0PMvozuBGT5eluf62lak1oNSzt0zSR4vP59wEnO
 +ykVI7A9yEf5l5G5RHnSVWuIOSpmJ4wl95UVNC7bPvRXFNdhUFBMlWu2+0SxMqBtTJPt
 I1QM48cpR4QkHSjPYQteRc6WvjOYHjIYmZ3afVoG+OUOouhX05mReVotNVoGiVgf7w+n
 PGLlk4URtukJqYIWjtQCMJMoIvR8W30HzK3t7nEjULSCT2a35S9q79uKydkUoeW3v2z8
 +CFOaoBW03+paFhLOBCtcKBCM2HiHr4exxWWuaplpLXzo7NkHfgwHngQUIDtyOJqCO9H
 kI+Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrYcdy6pySo/E7pRkkqnyjdBOdEdMudioF6gZG3chcVd9Br9pw2dJFDUGmYf5dQYYtYIeWwp06kw6Gu@nongnu.org
X-Gm-Message-State: AOJu0YyzgoG9UwOb2Q7ev9FPuthx9zDswpqumu4p1RCiTasApdkI6jF6
 nS6Zcq3aXMdHpAUhAZXEMQpdW0fkBrO3OaGgQiswyDZmlBKD6hQwC3r5CKYtRh4gS6iUww9Yl59
 zzg0d5L53yHmIaxZSGZY7fBa+qNfDqw2GLaM5YY2fow8Bqy7uH83gKXfg
X-Gm-Gg: AR+sD13/SUux2rTJ22YexounjNw0To5Bj/q75h83X81cY1EIE5PJQuPFtLbRZ6II2SL
 o7vWT3IzJf4xvpMHQEUsCi/rxixt6z39dQm3la7XHNT1SGLwX6XI3kgdNZPP04zplNNHBT0aQpl
 d+cvGQTPrmQ0iPWAdfwpW7lcpwQyFayLqnrxjB0sJAizX807Wv6hAFXHM4s2tabKGCJT59zmiAg
 jpW2wVY65cfNcrnAT4j6L2NSobN2qBIfObKcsOPZctbTXDP4sdIZGbXipJxVqdHwMRHJCN1ez9j
 iswoEWBXv9yPOtTqydnnqdzJUGqvw+v5FrrYeosWjRycV9LjslikFnmJ4pCfG1vVXyKW8ylA
X-Received: by 2002:a05:6102:5248:b0:635:1bc8:3563 with SMTP id
 ada2fe7eead31-750408b97b7mr3823319137.20.1785161026176; 
 Mon, 27 Jul 2026 07:03:46 -0700 (PDT)
X-Received: by 2002:a05:6102:5248:b0:635:1bc8:3563 with SMTP id
 ada2fe7eead31-750408b97b7mr3823259137.20.1785161025552; 
 Mon, 27 Jul 2026 07:03:45 -0700 (PDT)
Received: from x1.local ([2605:8d80:6c21:6818:c87e:c65f:8297:5636])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-750362ea1c5sm5486039137.7.2026.07.27.07.03.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 07:03:44 -0700 (PDT)
Date: Mon, 27 Jul 2026 10:03:41 -0400
From: Peter Xu <peterx@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, mst@redhat.com,
 philmd@oss.qualcomm.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, alex@shazbot.org, berrange@redhat.com,
 philmd@mailo.com, david@kernel.org, clg@redhat.com,
 pbonzini@redhat.com, phrdina@redhat.com, jugraham@redhat.com,
 liugang24219@sangfor.com.cn, dinghui@sangfor.com.cn, shan.gavin@gmail.com
Subject: Re: [PATCH v4 1/3] system/memory: Use memmove() for directly
 accessible regions
Message-ID: <amdlPQtJNoJV3e_o@x1.local>
References: <20260727032649.145381-1-gshan@redhat.com>
 <20260727032649.145381-2-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260727032649.145381-2-gshan@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jul 27, 2026 at 01:26:47PM +1000, Gavin Shan wrote:
> Similar to what's done in commit 4a73aee88140 ("softmmu: Use memmove in
> flatview_write_continue"), there are more sites where the overlapping
> source and destination buffer are allowed for the directly accessible
> regions. Use memmove() in those sites, listed as below.
> 
>   hw/remote/vfio-user-obj.c::vfu_object_mr_rw
>   include/system/memory.h::address_space_read
>   system/physmem.c::flatview_read_continue_step
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


