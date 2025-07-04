Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2595FC83F09
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:42:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjLj-0000Tc-GM; Fri, 04 Jul 2025 12:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uXjLf-0000Eb-Ou
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:33:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uXjLd-0000uS-9h
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:33:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751646791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qr5Bgh0PTiEstAeW1tk0iNy0LG2L2smYXdefK5Bb05M=;
 b=QUv1ImWx2FwrCQ4kQzD3GeKicRKXs8bdZOumpCV8CLnG8Z6yhGXhsNCwP/Ed6VbmgZWgKr
 fH0LcDo9Do60yFVVxVJLmZArCMUlO/XNRlKNHiIahmxfl0GySYzNgVR09x1eDK1EesfNId
 JTS3wVcPO671T3cKYUNNNTZtDCNazpQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-8Qvox13wN-691jAWjq7_yA-1; Fri, 04 Jul 2025 12:33:10 -0400
X-MC-Unique: 8Qvox13wN-691jAWjq7_yA-1
X-Mimecast-MFC-AGG-ID: 8Qvox13wN-691jAWjq7_yA_1751646789
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4a98d1ed40aso24716391cf.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:33:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646789; x=1752251589;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qr5Bgh0PTiEstAeW1tk0iNy0LG2L2smYXdefK5Bb05M=;
 b=PJRuDgBvde4M6GaAf8/76iu6jqPwNPs/nsY9jH7l/szPPSsPOpka4ydowW5R/G/UiM
 aRidID8F7vgpIjc4XpU47i1UzVXH3rNdvmEnjO7Y519iOnymGCh25qWvOGmXPYGazxiK
 X1qIImya/NDRqlLqXvzftjRl2NDzVWREeAGcKoX4Otx6+7KyP2kqH3ajRnTgcK3h+04c
 LbK72slnhGC2bfPyIpA34q1INk6Z8t4u018X6Rgx8B4U4YxGoLMIsNsiUvEUMaOJQlsl
 oXl8CrlT6t4BpamHguLa0IDasO7tOfh/FfSns6GW758hXPafL54S0KL/aDIf5ce/CkbN
 KVpQ==
X-Gm-Message-State: AOJu0YxvML/+G9LhLj9uD1zqXHvE8Px6ORgnbeFK+w+k5hFGtgZ5j42M
 BNzE4EWB3BtELX1uEaia3QKe/B0FEmpUXYfkpqOh4XUFXqJK2G9m1Tfkd2bTbqdD+oB3vIVeZwx
 nCTZeQ2PkKxPHWTzANjmsbtbM2GjWicClKBKJ2sHmakdC3O7U8PpVC40C
X-Gm-Gg: ASbGncuw4zQpdug1pPjUtgV90SSLOx/sXfxtH2OkmywmQcRVSbBVBS0F7/J0nhXBMXj
 409qROIchtdxzz61yS6mq5YhU3A+ptdOcu9zk2gx7wMmHl1wlOj2v3gSciUWvUqa01Dex2ByxpT
 QrTc5DcJbTpfzeqHBOaV77294jYRWRzviBiEWrQwroNGZIs5OFbcbTagBGqL9tGMkT+5L8lUKo+
 e1x/7AVCZz2UCrru4hCdh4guvwx2+jSlq5nd17/kmZTcbUcR7iyIREqMcxemAnjiX1R8FR2kqSU
 akq035pnz3PuKQ==
X-Received: by 2002:ac8:5c8f:0:b0:4a8:5a:9e2f with SMTP id
 d75a77b69052e-4a996408befmr41134351cf.8.1751646789555; 
 Fri, 04 Jul 2025 09:33:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH29YhOMjXtmwjyURpnJ2zC4FrF+f30EU0unwrVVnOFPtg4A7QHZm283umZ1J3Q+KoiUNkScQ==
X-Received: by 2002:ac8:5c8f:0:b0:4a8:5a:9e2f with SMTP id
 d75a77b69052e-4a996408befmr41133921cf.8.1751646789089; 
 Fri, 04 Jul 2025 09:33:09 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a9949f98f0sm16682511cf.18.2025.07.04.09.33.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:33:08 -0700 (PDT)
Date: Fri, 4 Jul 2025 12:33:05 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 16/24] migration: Add capabilities into
 MigrationParameters
Message-ID: <aGgCQdJ4S75a0vdx@x1.local>
References: <20250630195913.28033-1-farosas@suse.de>
 <20250630195913.28033-17-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250630195913.28033-17-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.218, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jun 30, 2025 at 04:59:05PM -0300, Fabiano Rosas wrote:
> Add capabilities to MigrationParameters. This structure will hold all
> migration options. Capabilities will go away in the next patch.
> 
> Also add capabilities to MigrationParameter as the enum needs to be
> kept in sync with MigrationParameters. This affects the parsing of
> migration HMP commands so make the necessary additions there too.
> 
> From this point on, both QMP and HMP versions of
> migrate-set-parameters and query-migrate-parameters gain the ability
> to work with capabilities.
> 
> With MigrationParameters now having members for each capability, the
> migration capabilities commands (query-migrate-capabilities,
> migrate-set-capabilities) will soon be deprecated. Add a set of
> helpers to convert between the old MigrationCapability representation
> and the new representation as members of MigrationParameters.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


