Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9020C606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 05:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aLWKfe76
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ2G7-0007zt-Id; Tue, 20 Oct 2026 01:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <narimansayed28@gmail.com>)
 id 1xJ2G5-0007zj-K3
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 01:19:33 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <narimansayed28@gmail.com>)
 id 1xJ2G4-0002Q4-5q
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 01:19:33 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-8ac9d666d4eso22015617b3.3
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 22:19:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792473570; cv=none;
 d=google.com; s=arc-20260327;
 b=eem1fR+i2RvtSwgLiOb636kvmhcDCkJb1vU06aY49Tz9BFVNDEWOC6B8XeyZ+x5wRk
 lBqLN+Jd3Zp3VNDxgW528YKZxu6qKWRpqseFtGPvjr2Vb3Mp31u+Z5iCqX3tZEwy93p5
 1cZLaGgaohLLDqI1zCdpXPjLiAMgVVGfkLZSzgcDRzdUKdRn9vv/6JA0En3zqNZsfoXu
 h1xago/XO6yTJefe1YY+BBnv4013Zc3qj3lcUYxY4ZP67Rdn8C8Jd7vkC79HhZcco3Ag
 oBsClBtCxmoGNz/bfh+mUwQvewLMeIwOLgxwG/Z7gj04EhOfxm92GUBhVBQ3djs1WgZH
 BwlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=t9BKnM0BpbxCJhwTAA/hwXDetQNhgLU9H2HkaPMoY2M=;
 fh=ugCR53l5sS+hYj4DL89NT/nxlz8B6K0lucpJvtFd2Mw=;
 b=Pg24e5XWoBRHcvHUDWD5yRNWitbs3//qN+TWQOGU0UaRsVR0mk9IeS85aVWtUmDgYw
 hBBq+r/o50N2Oad8iCYqxdyECaAyYZ010N/VczGkigrBS/MBwyuea4caLugeFxS2BAWF
 DfF5ZnDPiMGJz1T31LnQ3iEa8CMsQe9M7lbqSkGVn+2hZsE++pd1jc7I184dV9FkIwPM
 Xv33TDRj1CnPROO7XSdQUTPMHvRmcpbFcxm3AuaS1Zqrwn5Jy/b6uy8Vcic3BBmDh02H
 Vq5Ro2plKAjuGz4ewEWpyEsfqPeo0WmW9MzeTzz0b7fS5OLKNJJDMHe0FhO8w9aSXSHm
 POGA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792473570; x=1793078370; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=t9BKnM0BpbxCJhwTAA/hwXDetQNhgLU9H2HkaPMoY2M=;
 b=aLWKfe76rmzJFPDGQ+p9a2LyKECVGZU3lknWJaw0gOtqf5N96/5BNfASijOsnUWypC
 dIi6A7hfl/nG7puXQRvSi7kAlp11Ic6zujJFKy2SuK5KvRpzYTMQvHNZenCYJs9bSR2X
 21jem5ywY2H6nEOTEKVOJz6GUweRuTUH7cODGlW2oD49+uPme7D/7SZXGJPrTm5dmMGr
 w/uJHdO1DbfpHLRddtyEHgzalbk47n4YRK/UBjMNO6xDI0GVV+dIDsO3rVTbTXcnMlB4
 jcHS79P0dqfDRYamNbcilmprBnOYyF08p68jTgErbmUPfr3FamUuoGW5dEsA3SLKdDQQ
 WdYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792473570; x=1793078370;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=t9BKnM0BpbxCJhwTAA/hwXDetQNhgLU9H2HkaPMoY2M=;
 b=pcwvcOxFZzmLHEy7fDmmRD2WiEQazjwti0Iw5ObX+X+Z0ng63nR9F1hp3+KkML5fkv
 1b5zw+HEU6KlQOkh4pYMeUK/6UeZT/3jCZ9xZbObnjigGXM4SgXBuTOnkOnN6C2KQfKI
 zb3ZbExwiDi6wXZ86MYJN1BiYAULPVDLGrKFSqtCFe0EvFye8W3c4vLfNBO3vG7JdShz
 pKfMOno2KAfC4WZy84zQDye6pAqMXe3a0vq7jK5zeSrmX0lBD5GwjLvg/nIPPm2QmKqf
 6cHrKUY4EYsdwpA3ePxTaVsYuleH47BjXfmwCd9IRf52D+kI1xB/3ys42THrJbvdPhNc
 h7PQ==
X-Gm-Message-State: AFq9FYLV/9+/xyFVHRzl/MMFWifgwwKv1DH2ivQf9kVqhrVFPs/q3bf3
 94MW3kVr0xO57dkmMKxBouDbHB9047w9UtvS707/RS6uncJ+xyQPlu9vKdh+dpyRC+03efdjFeh
 9tkc42TUMY9ZE/sjEWAxzWF1uxqbMwgq8qqOuPeA=
X-Gm-Gg: AYBFou3GZa+MFSklB+MotD63sYEtk1J1yWJiExfqgDfyafdMC3vDOiZDVvURQhu3Ll1
 OXfkNIVLAYLF9fiz8rG28W6LEmrNHKJNPH5b266sOdWskcaIsuYwiVptsd/g8aGqmp+j50y63Ii
 yXp87p4E5IZkFVeQbY+pvvGqJsrAeXT7QN0bF/Czzu6OF0xjfX79q2ni9X6rAaHvqMmu6Snegh4
 xaXu5DpgOmR7kRbQICW3fy5OjUlyIjympKH0eRxU86TWCYxlln9p3N5sLeQR/PZH4rxxoxTnY7m
 y7Q7nANz1QW1+VXkIfhZ1u50O0ETUigj8rRwQAUcVhXp1su1SZWpOm1Mu7OaeSpymaQ=
X-Received: by 2002:a05:690c:88:b0:8b0:ab14:7b3e with SMTP id
 00721157ae682-8b0f21c922dmr24420227b3.76.1792473570562; Mon, 19 Oct 2026
 22:19:30 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260816043451.2547-1-narimansayed28@gmail.com>
 <20261007050718.926-1-narimansayed28@gmail.com>
In-Reply-To: <20261007050718.926-1-narimansayed28@gmail.com>
From: Nariman Sayed <narimansayed28@gmail.com>
Date: Tue, 20 Oct 2026 08:19:19 +0300
X-Gm-Features: AclHuK9njDRog10YxS8FEEXC0jOpJ3UolVs_4VYkHO9F2xcL_4tntHf8gHC7AvM
Message-ID: <CACt+UE7HTzkeym-4GCy7YnzX=XM_zUBPE6Pbi71dPcCcTi6PLQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] net/tap,
 virtio-net: auto-detect MTU from host tap device
To: qemu-devel@nongnu.org, Eugenio Perez Martin <eperezma@redhat.com>
Cc: Jason Wang <jasowangio@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=narimansayed28@gmail.com; helo=mail-yw1-x1133.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi all,

Gentle ping on this series. v2 addresses Eugenio's feedback by adding
a generic get_mtu callback to NetClientInfo, so virtio-net no longer
checks the backend type.

Jason, Michael, could you please take a look when you have time?

Thanks,
Nariman

