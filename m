Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FB2606A327
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gfV1Uiln;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=CAdyd4A3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRUe1-0002Li-4J; Thu, 12 Nov 2026 08:15:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xRUdy-0002Es-Nb
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:15:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xRUdw-0005gF-TO
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:15:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794489308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7WYaaUXbSOKnFfF2E6Vy9wmMz9dgSEtczUz0i/AjRFk=;
 b=gfV1UilnTK/6OwRhRQGSPFlRnWrWfHsEiFZMDyWFxOzLdiGgmuWUsWYDSws12GCULFXV/0
 UYa+mLWG/S1db9JWvtWHbk/BzL8qB6k7f0T1TjhBugFPGfaQFrd+ZhGu0LX7PfekZelpLS
 1PN2RgQ8GiieFMXRvjrz6okaoqeFsVI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-B0l7cd4RMv6B8D2K5o3rpQ-1; Thu, 12 Nov 2026 08:15:06 -0500
X-MC-Unique: B0l7cd4RMv6B8D2K5o3rpQ-1
X-Mimecast-MFC-AGG-ID: B0l7cd4RMv6B8D2K5o3rpQ_1794489305
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4ad3d35e899so34733205e9.1
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 05:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794489305; x=1795094105; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7WYaaUXbSOKnFfF2E6Vy9wmMz9dgSEtczUz0i/AjRFk=;
 b=CAdyd4A3LZl6f/oIjycIpBkDKGC+qiRWRw5WiL6Ng+Y2TqXavPKPSPT3Zc8HUCW+TY
 OjZdqZb/kFNy275ysLJGgGEXv90E+5AUHpku+2jq30fVlSNFEv5s2V7jFfzOcxfh+Hdb
 L9EF4oHIkS6hGx+CzyjRO+1hXqvhKWp62XLkzahkiwAwfk31JDZFgAvl5sg6ySmDwqDY
 ul0itoRWRzIr92msbCUn1tghLBMZbl0y084+EmrFs1lXlzoxZTvL7+RkNtojwF9LsGXE
 ZmogPN4wMltOuKtba6H35HeqngxBAPRbiv47K2dOSGAvlaCOsofqTcN8X4b9P6HVCng4
 LbQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794489305; x=1795094105;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7WYaaUXbSOKnFfF2E6Vy9wmMz9dgSEtczUz0i/AjRFk=;
 b=mO3miZZP6pUMifxKQfOgjAw59q4EukIK+C/M7cU1WYpGcJPjENCV1NGIleXm+Qcwvm
 eD7zSxMhc3oN6E+ADaah5yzIFYBqKJsBqazmlySpMV3QWTSrupP0VDJh3Oaq2Z5/OgiQ
 iGTVeiZPLPE2dbaEoHJ5+2Tcw2GVEB1FuxXXLip7Izel+QFAM0xuGzJVdCi8jCV6nf07
 b2Ug6cOcWFEazZD73qLYdoHkK5Cc9TiE+5r3ULGKphC1aI2tp/GqMTkDq7UMnAKaBfPb
 DeZE/kxAOy+pzns3FCjGbZ/SgVNem0Uzffhdo4GF7eQ7BTALMxgdzCVQP2b34QSeAiE1
 8Qnw==
X-Forwarded-Encrypted: i=1;
 AL+hErFDXJzUDSsm7M2PL0R7QuUPeOMigYCiFcrmHDQvN4iAeJ054gOGB05c+ismKMQFC16oQrrsPDOL5Zcf@nongnu.org
X-Gm-Message-State: APuU4Z9F/mPzRk5/Jm5k2pXKNg8eS4vi8/S+wLF0UzowQL/uit94uJRG
 NAcg46PVFQu3JH1tyhjyJOTJzAN+nv5g/jcr4ijsqsm3tgTWtdLxxbN+sQTJWqVUbGM+qR3QiLH
 EKQYpvT2wR+5H0gdzDDbRUm5BZI4VKGFnrDHzKj8JQp1OmzcrJZQjt223
X-Gm-Gg: AYBFou1YQ3dSFe5BgptZ1lk27miFIlH6Emus43MuSdvAnbOKlIFgHfG1OUhaGMtN8Wj
 0bC1L1mETlr6TyZrjcH9AwFGrN1Nn5YzTiDpeiRRHrY+zpAfw2/hX3GTOXSnAhhgVY675TBDyTR
 3waElAOVOS0R4FzhztQZWQ4uPth/7McxEHkdgBk+x8GglVQnajkLq+AiKOAURj8YlB0k4mQOx67
 RETnf4P2uQhblYky+qESzS9sir3DzkEOkBlxcjzpGKCewxi+U/ntyHWQSYM55nvE0iuwECacTQ1
 x5752ZRNQ6FQ729kI+Ur2bAHWhSGiBik9X6IqPMxKKQh+QaLfLe1D0gEDuCUc47Vd2RzCRBdm6h
 d9BRAh3sC/QMQpb+4x/BmtO+rzcw7RxHNCUo=
X-Received: by 2002:a05:600c:4f12:b0:4a2:191f:7cb8 with SMTP id
 5b1f17b1804b1-4ba09365bc4mr113152135e9.17.1794489305088; 
 Thu, 12 Nov 2026 05:15:05 -0800 (PST)
X-Received: by 2002:a05:600c:4f12:b0:4a2:191f:7cb8 with SMTP id
 5b1f17b1804b1-4ba09365bc4mr113151475e9.17.1794489304635; 
 Thu, 12 Nov 2026 05:15:04 -0800 (PST)
Received: from localhost ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e25e3bfsm69510245e9.7.2026.11.12.05.15.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Nov 2026 05:15:04 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Nov 2026 14:15:03 +0100
Message-Id: <DMT9D9ASJ4K4.33A9K51FM3PE2@redhat.com>
Cc: "Klaus Jensen" <k.jensen@samsung.com>,
 <qemu-devel-bounces+tcalifano=redhat.com@nongnu.org>
Subject: Re: [PATCH 2/3] hw/nvme: fix fdp reclaim unit accounting
From: "Tommaso Califano" <tcalifano@redhat.com>
To: "Klaus Jensen" <its@irrelevant.dk>, <qemu-devel@nongnu.org>, "Keith
 Busch" <kbusch@kernel.org>, "Jesper Devantier" <foss@defmacro.it>,
 <qemu-block@nongnu.org>
X-Mailer: aerc 0.22.0
References: <20261112-nvme-for-rc-v1-0-69b3e5dcd5c8@samsung.com>
 <20261112-nvme-for-rc-v1-2-69b3e5dcd5c8@samsung.com>
In-Reply-To: <20261112-nvme-for-rc-v1-2-69b3e5dcd5c8@samsung.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=tcalifano@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu Nov 12, 2026 at 10:53 AM CET, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>
> nvme_do_write_fdp falls back to placement handle zero for a write that
> has no Data Placement directive or where the placement identifier is
> invalid. However, it then passes the invalid placement identifier to
> nvme_update_ruh which results in no update to RUAMW for placement handle
> zero.
>
> Reset the placement identifier along with the handle in the fallback.
>
> Link: https://gitlab.com/qemu-project/qemu/-/work_items/4520

/s/Link/Resolves

> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>

Fixes tag and QEMU stable

> ---
>  hw/nvme/ctrl.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index 685cbc2f340c..a0d22dacedfa 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -3754,6 +3754,7 @@ static void nvme_do_write_fdp(NvmeCtrl *n, NvmeRequ=
est *req, uint64_t slba,
>          !nvme_parse_pid(ns, pid, &ph, &rg)) {
>          ph =3D 0;
>          rg =3D 0;
> +        pid =3D 0;
>      }
> =20
>      ruhid =3D ns->fdp.phs[ph];

Thanks,
Tommaso


