Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BECCC54E49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 09:02:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reWrS-0004VU-BH; Mon, 26 Feb 2024 04:01:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reWrR-0004Uu-Cu
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 04:01:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reWrP-0002l5-Vu
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 04:01:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708938078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LG1v1RlOEltJThm61dDzjy4J1Pxvqzv2IToclSKtxgY=;
 b=DFB7zu8K0/4LIxHxbVWY5ETOBHfZwlu70rbj+zEs+aTYb51JPWeZlUAmXlhR5z/Ny5zBFW
 IuDvJo95oWvEbK0jE8+OzAiBEjyxsynf/6MQc3gkpKMt9PtYcrvG1LU4Ha5VU4HaWtuLJR
 GRSLiYZyh7mPGVOZwupmBAdyTJWQZ3o=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-ZUtnGmhnPN-JsdrhFj1GqA-1; Mon, 26 Feb 2024 04:01:17 -0500
X-MC-Unique: ZUtnGmhnPN-JsdrhFj1GqA-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-5dc97ac2facso1330250a12.0
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 01:01:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708938076; x=1709542876;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LG1v1RlOEltJThm61dDzjy4J1Pxvqzv2IToclSKtxgY=;
 b=r0tQYDLfoINzY80uljgWgRsHsCu5++w71QNrSaf6z79VcfP+NtzxkBFVgWvABYgVn6
 oEgPgGBpWBOZRByDlKwOywED3Hq8rt3pl0L4DvwSbzuGe3LB9+J0j6Ws8N05hAc3lX14
 5TOdpAWDqXn5xczvA5w21WDS3ngIhl3ufdzhpIW7pfjzXpvOxnCt8ts8RThNqD8y9u+0
 Gw/XrvHmpjOnR/FTxi5/jc7K32jNqRSJrV9udsCvayXIE7LIAvvk9JeisWI3o8VqlUT2
 3i8VS29J74Og9Txa61jJrWoZ6hrXVYhqagNHSv9MOKiI/WQsbKFq629lltPPPTB3kCGj
 Hlgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZrAmpX0D9gNUZu8wASI87BtZBd7z/jVQoByt9ECqYXDj/0uqj9Odl/boHejyV/Y+Y3BASXpo9UkFckDiAr2uVW+ugAFw=
X-Gm-Message-State: AOJu0YyeknM49hgWurjnNou/zZvOxkibFPUXrmoB2H2M8pYLJOMw7aEy
 IaBD+eboWXnVNaNrn+i1UPQuB9gkfhFtQH3y04ugQmHlupnYvlKu3J6JU3ZMm1SO3fno07Hrm6O
 dxWKB1aqtEoLlq4pKtBIvRCCYPsH0KolAoOSuGprQhSTRAWb9fuFX
X-Received: by 2002:a17:90a:15cf:b0:298:bc90:3b69 with SMTP id
 w15-20020a17090a15cf00b00298bc903b69mr4529321pjd.3.1708938075625; 
 Mon, 26 Feb 2024 01:01:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAjZMCh67wJMNYUiDxAb36Ccns6tsemyoMqVkLvslDw1kCn1Fl7dHwEbv7joFVQhbf8WQHRw==
X-Received: by 2002:a17:90a:15cf:b0:298:bc90:3b69 with SMTP id
 w15-20020a17090a15cf00b00298bc903b69mr4529300pjd.3.1708938075308; 
 Mon, 26 Feb 2024 01:01:15 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 cu12-20020a17090afa8c00b00298f2ad430csm3931334pjb.0.2024.02.26.01.01.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 01:01:15 -0800 (PST)
Date: Mon, 26 Feb 2024 17:01:08 +0800
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH V4 00/14] allow cpr-reboot for vfio
Message-ID: <ZdxTVHJ8p4lYRPxo@x1n>
References: <1708622920-68779-1-git-send-email-steven.sistare@oracle.com>
 <c95b3c15-0154-438c-baa0-98f4c539355a@oracle.com>
 <Zdv0BNtJxkd8413g@x1n>
 <02bf2132-ed34-4ecd-841b-5f93eded7ea4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <02bf2132-ed34-4ecd-841b-5f93eded7ea4@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Feb 26, 2024 at 09:49:46AM +0100, Cédric Le Goater wrote:
> Go ahead. It will help me for the changes I am doing on error reporting
> for VFIO migration. I will rebase on top.

Thanks for confirming.  I queued the migration patches then, but leave the
two vfio one for further discussion.

-- 
Peter Xu


