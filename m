Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF5DAC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 19:14:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk7Zt-0002fQ-37; Tue, 12 Mar 2024 15:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rk7Zr-0002dS-CK
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 15:14:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rk7Zp-0007HF-Il
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 15:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710270854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QpI0tR/k6hCJFryOsfE2RSofpUR2ZXFQ2ZWMG1N8i2o=;
 b=fywTPVJbXwxm78Gkhdtz7nFzkAEOrX0Ro9zjiMdD0siKjLmEcZ2WthiOnTT7FT131Zg83J
 +ilkfCObYUPKEhY7h0n34NECOmFBkjfBoVMOpWCUTgksxyr5izXmNccyCOPCVVXfj11u1B
 y/YgDrcvaGyk6JFZUEY6S9aAwQM8Yek=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-HOcRC647NyWjNmEdnA5yFw-1; Tue, 12 Mar 2024 15:14:13 -0400
X-MC-Unique: HOcRC647NyWjNmEdnA5yFw-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-2218be82ae7so1485623fac.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 12:14:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710270851; x=1710875651;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QpI0tR/k6hCJFryOsfE2RSofpUR2ZXFQ2ZWMG1N8i2o=;
 b=Ay1H7SONITsoHLoJR6kzAuT78glwXdrLfRjDBNPCoLP3iAV4PUxHeYsU+G4ywWCW5l
 CYABIuwZWts0hUet6kYXknTcCRsKLJhST4nhUUQNMpAsdW11jWBF2mgZ9x50CIUZeOEH
 VImoe64HTyNrAIhAd6sQ3FPZNqtWJkvOoITIbr1my1v5fYbtbCSFVCvsl2SEQ96kmkhe
 EpASd98VCMm88kh00zpxtTCFwsOk9AMhbAd+j/TaZkhioRXE/A2B1JwMZ4gmZi/FdWU8
 3hOckOLMMkyoywvnuHMK0Ndt5L2EHjk8J3KXJzpfDc69xup11O2X5vsghMHt324Oci00
 TsVA==
X-Gm-Message-State: AOJu0YzrSzyBGf2eUKw5yYZkQn1/zB3KOXkiOJedidutU6/LYAq/UXn2
 t0deB+BOE7OvP622PiIXBsuQVFj4WYBtpXmGDKEZeHokkUixU9+mNGeg61cSknQVeCgE65aLvvh
 dFV5woj9tRG5Sbj+CS0j2LFYGAdzxs66/Z0Fs7I7DJuRaAGrEyg2t
X-Received: by 2002:a05:6870:f787:b0:222:2153:e267 with SMTP id
 fs7-20020a056870f78700b002222153e267mr2600142oab.3.1710270851272; 
 Tue, 12 Mar 2024 12:14:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2+BLpk82nzvy4D87L5UsprRvWYUlaXXu4lopKhc56a3H7sxZt8U6no42LZBymA5unsXV65w==
X-Received: by 2002:a05:6870:f787:b0:222:2153:e267 with SMTP id
 fs7-20020a056870f78700b002222153e267mr2600130oab.3.1710270850939; 
 Tue, 12 Mar 2024 12:14:10 -0700 (PDT)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 xx23-20020a05620a5d9700b007881e40ce0bsm3957194qkn.83.2024.03.12.12.14.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 12:14:10 -0700 (PDT)
Date: Tue, 12 Mar 2024 15:14:08 -0400
From: Peter Xu <peterx@redhat.com>
To: Het Gala <het.gala@nutanix.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, pbonzini@redhat.com, farosas@suse.de
Subject: Re: [PATCH v6 0/8] qtest: migration: Add tests for introducing
 'channels' argument in migrate QAPIs
Message-ID: <ZfCpgJ6dvorlpfO1@x1n>
References: <20240312162025.44212-1-het.gala@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240312162025.44212-1-het.gala@nutanix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Het,

Could you rebase this to latest master?

Meanwhile, please provide a prefix in each of the subjects, it can be any
of "tests/migration-test:", "tests/qtest/migration", "tests/migration",
etc.  I don't think we have a rule yet.. but any such prefix is still
helpful.

Thanks,

-- 
Peter Xu


