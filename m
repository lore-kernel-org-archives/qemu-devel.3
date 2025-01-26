Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B95C02181
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 18:08:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tc72e-0000gD-JQ; Sun, 26 Jan 2025 13:07:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tc72c-0000fp-RK
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 13:07:26 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tc72a-0002Nb-Ue
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 13:07:26 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1737914827; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=R9WEOClMPtoIpHGQBSvRrpeKIl3nd14try/8D0dnrrGqyPgBmFy0P/uYItM0OtZI5ZEQX40IAAHUKiu/qEuRXttWs3o1/QHshD5ZGTERrHlcjLZecEZtbdTcs9b2iPpF0KJrd2z3gUvdKDPjmcYSVu2RM1hy+84gkBp8fZPtpNU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1737914827;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=su8rSglxTIz3gB+hOFD2DaIesMGL4EHAM0y4k1cURio=; 
 b=SqdEvP5m0OTaOJA+2uWr54jb3SMjOfXJl+bjfWr1N5lhxhi450+rEB4kUS/jbj8GYH3jYf7i7LTJTnbTplFpQ7p/KrIFsQzAw0qAWjcnULhYI7JZDGdytudMlkH804a59rH7RO/JyYU386DwuAjg2f6taeSgRFD9/G0JeOaIGYg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1737914827; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=su8rSglxTIz3gB+hOFD2DaIesMGL4EHAM0y4k1cURio=;
 b=N8GTU8UER8BJ1gGMw7YFjvIEvG23RQ53DmZzqSCOciaCs/0cdyswUScGu3r2CPcc
 5jiWB1kjz7KD56U1+1adePuhtJDqOeP0gC8AS9l2ySOcrzP5kkdoPFO3eaHy+O1Nj8E
 mVHRtsTxY4gplSjsSpV07XwqmZMG0zXGUuodH2A4=
Received: by mx.zohomail.com with SMTPS id 1737914821167963.8096463258325;
 Sun, 26 Jan 2025 10:07:01 -0800 (PST)
Message-ID: <ea866d19-90f6-4bb9-a3f6-f84b2ea2c457@collabora.com>
Date: Sun, 26 Jan 2025 21:06:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/8] docs/system: Expand the virtio-gpu documentation
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gert Wollny
 <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Yiwei Zhang <zzyiwei@chromium.org>, Sergio Lopez Pascual <slp@redhat.com>
References: <20250119220050.15167-1-dmitry.osipenko@collabora.com>
 <20250119220050.15167-9-dmitry.osipenko@collabora.com>
 <c2e1c362-5d02-488e-b849-d0b14781a60f@daynix.com>
 <87ikq9r7wj.fsf@draig.linaro.org>
 <171b1cd3-1077-438c-a27c-3b9b3ce25f0f@daynix.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <171b1cd3-1077-438c-a27c-3b9b3ce25f0f@daynix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 1/21/25 07:26, Akihiko Odaki wrote:
...
>>> I feel the dependency information for virglrenderer and Mesa are more
>>> suited for the Mesa documentation as they are not specific to QEMU and
>>> potentially useful also for e.g., libkrun and crosvm.
>>
>> I think while everything is in so much flux it doesn't hurt to include
>> in our docs. I don't know if mesa currently has a dedicated page for GPU
>> virtualisation.
> 
> Mesa has pages for VirGL and Venus, which can be linked from the
> respective parts of this documentation. gfxstream is not documented but
> I think most people will use it only for Android anyway. A documentation
> for DRM native context will be a nice addition for Mesa. I will not
> object if you put this information to QEMU documentation though.

Adding native context doc to Mesa indeed will be a good move, as well as
adding links to the Mesa virgl/venus pages in QEMU.

RE requirements documentation, it's also a valid point that stuff like
build flags should belong to the relevant projects. On the other hand,
it's a common headache for a newcoming people to figure everything out
from scratch and having more centralized documentation helps. The build
requirements aren't cleanly documented anywhere AFAICT, and the
requirements also differ based on VMM. I'll update and keep this patch
in v6, the requirements info should stay actual for a next couple years
IMO. Let's discuss it further in v6 if more objections will arise.

-- 
Best regards,
Dmitry

