Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD97FCA16E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 18:26:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzfIc-00033q-Ru; Mon, 09 Mar 2026 14:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzfIM-00031x-03
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:25:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzfIF-0001Nx-Hv
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:25:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773080726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V1NoNWgfZfwg6itK+lLijN2TFmQfhew6eaFCQUiG1XI=;
 b=Mvn+KWWFJImW9vzOiCVetOtBEW/X3XWTinvOV6qu23R8QXI1UuGRrJR1K4Y3TR+vZoDhJJ
 kL0rKTCC55nGz34tY6+ZpRMB419xK8VMseV6rt2TGZePgVzKLcjPNuJB/NJMqju9EKDpsm
 1HU4BwcveSCRkCbaQPdmqew1cyTr2dM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-DHv1IH-FP8OaAKMsbuCL6w-1; Mon, 09 Mar 2026 14:25:24 -0400
X-MC-Unique: DHv1IH-FP8OaAKMsbuCL6w-1
X-Mimecast-MFC-AGG-ID: DHv1IH-FP8OaAKMsbuCL6w_1773080724
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-509219f94b0so40439811cf.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 11:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773080724; x=1773685524; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=V1NoNWgfZfwg6itK+lLijN2TFmQfhew6eaFCQUiG1XI=;
 b=E3ll+IogZpP95slWdtzhC4+NL8jof7zOmN1Fy8ASspSC+7G4ljpx8VCWEaoQ6N14sD
 xBt/XTN9mmRJtv7MWj1toNgjihx/VXrWY8lpGt7owY4ohBOOLpPE67bNeJnwyKyLgjg2
 kdEOxr58ScHZIh72FFLnC21vaztYx1U+y2p1XMQWveiPY/Z+ZSSCCsJUpdAOEHLQUdiy
 FGdM+OD1soWdLYUbUQN/JGn6YE307Whq3mY2aYauYZC4gosZ4XqV1xbKMeOvYJDHTaNw
 FuwHfErxDgLUSg6WgSQ6Hx7HasASkY2eIi2BCkb/1GcBvPJg7qaG9ZjNAjm22efdHFEB
 VjPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773080724; x=1773685524;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V1NoNWgfZfwg6itK+lLijN2TFmQfhew6eaFCQUiG1XI=;
 b=If5ubIBz2En1Ooib2ridZB80wDnh5Ed9ipsLGS8hbpZlAZFKo1feU423ppPOqJmhEO
 F26Y9qV0mzlmrhyrLw449Dh2dbz5bCCDeeud9u49DNPg3/yN9KCSYZ4M+FY28xfbmQYL
 OIQUsV7T+r0MzZ7vZRlEX/8xl2tZrsMr/n9gdiBr6nXWcr2u0tiDkIfFeMvlQnDAzDr6
 BHDobbQIbnSdUAAdULUJkSpxAFoF0opqadNyUyIdcr+bAT2Q2gtyh87rJDhYcknJYpaM
 Q55MCgRCZTBo3CCq4RwJS6SixFAfKKSiISrK7HOXxT4yML4YgHhDgYoG1CZYUHGZw8lN
 /VGA==
X-Gm-Message-State: AOJu0YxhDOgDoMAm7ItheVaks2aw2CdPBKIPBXLWmfih8j6hXuMbh4Ef
 QLShgv1CK06aNQVXb51X+zpUaILvRc1qgbds0ilTGoVHhSKK6ZGzvWdWrUYGP3HhmbgR/6Cwp7z
 OLrrPobAOhB8ZWuAQVBPUDKLyKkUyoZCCX0yFp3otG00yvyOnfVt8xlbA
X-Gm-Gg: ATEYQzxbxutDCHl2CDutYPfbGHGeKuLnuoAyPzORj8i8hz3fM0Tf513kgmPef7dBa9O
 HoQhbfThZzSfr9y3wAGBzFyBa6ERaAOx6ilWyvdg6SWrbtco4ouN5sRT0N1Bn9nX48AvMTUr+rv
 UR7hoC0/M5QvPxKe9MXSM83gSRgwYnbLEYbR/xIK78imeyLZ9yBMVHkt+4qq+ibnp5J4OgD2YMk
 s3oDBKK3/uTunHlffg3kui+F1dcPQmpPWBO3WxnhDM5YIiXlQg2/Jhg05WXyS/Ht68IxObnXpA4
 m2k9U8IFSH29Ju+qR16z0jXhtFM2v9CHH6kbJHwJfFyVHzbTjXrxuTQbCq9UyrVxppFddP15zAk
 CZKB+lYP+FzEIYO3C2DmXUYHvfEGyNTVqZEyXq4/t77cp9xFnG5e1xr+AR2C+hTCDC6EpH+/4x6
 Y7Qumh8w==
X-Received: by 2002:ac8:7dc2:0:b0:509:1ad4:62f9 with SMTP id
 d75a77b69052e-5091ad46e9amr54083801cf.4.1773080724169; 
 Mon, 09 Mar 2026 11:25:24 -0700 (PDT)
X-Received: by 2002:ac8:7dc2:0:b0:509:1ad4:62f9 with SMTP id
 d75a77b69052e-5091ad46e9amr54083411cf.4.1773080723642; 
 Mon, 09 Mar 2026 11:25:23 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-149.dsl.bell.ca. [174.91.117.149])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5092657fba3sm2429841cf.3.2026.03.09.11.25.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 11:25:22 -0700 (PDT)
Date: Mon, 9 Mar 2026 14:25:21 -0400
From: Peter Xu <peterx@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Ben Chaney <bchaney@akamai.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex@shazbot.org>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Mark Kanda <mark.kanda@oracle.com>
Subject: Re: [PATCH v3 00/15] Make RamDiscardManager work with multiple sources
Message-ID: <aa8Qka5kY8zd8IGh@x1.local>
References: <20260226140001.3622334-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260226140001.3622334-1-marcandre.lureau@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Feb 26, 2026 at 02:59:45PM +0100, marcandre.lureau@redhat.com wrote:
> Marc-André Lureau (15):
>   system/rba: use DIV_ROUND_UP
>   memory: drop RamDiscardListener::double_discard_supported
>   virtio-mem: use warn_report_err_once()
>   system/memory: minor doc fix
>   kvm: replace RamDicardManager by the RamBlockAttribute

If no objection, I'll queue these init five patches for 11.0.

Thanks,

-- 
Peter Xu


