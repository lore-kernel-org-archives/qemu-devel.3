Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26751FD3762
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 14:35:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvFy8-0005IL-Og; Wed, 25 Feb 2026 09:34:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.699f03f1.v1-03d8c58766eb4205ae529e497ec5d511@bounce.vates.tech>)
 id 1vvFxx-0005HH-Co
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 09:34:18 -0500
Received: from mail186-12.suw21.mandrillapp.com ([198.2.186.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.699f03f1.v1-03d8c58766eb4205ae529e497ec5d511@bounce.vates.tech>)
 id 1vvFxv-0004qz-MQ
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 09:34:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
 s=mte1; t=1772028913; x=1772298913;
 bh=JGWN5jkvYY71URPpUEe8IqNYzfuwlhJJo5SoK8DxtuE=;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Feedback-ID:
 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
 Subject:From;
 b=mrQYZ+wLz3+s8KQfcz1wlvRqwPY2981AKwC5KfmyCxtxLLBEWuSKhx9f08TbbkDq1
 NfCSFzyiuwObIT3eL2UWvi8przDLX3Mx5rWiy8Vm9IvxmVXwW9AXdeQVbITL7HxC3+
 y2kFoO7OS9kGPJ0iaTgNigdjwvvMyUOcReCLts+Gkfo1yls+lGxrCDjYlnvL/YUTai
 QWx1fu5KWOeqW7PueZgH+AYVj4WAQUMhQgH3JO8tI8qYLRtgr+iiLoCcAOxhiiyUSZ
 cSNF5PZdvcOrDYyKbsS8Em3H3k1bAJrHEDVbT0v5ObehW43sBC2AuSHEAvI2Mv2Bm1
 8tJXBz6pyh92g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
 t=1772028913; x=1772289413; i=anthony.perard@vates.tech;
 bh=JGWN5jkvYY71URPpUEe8IqNYzfuwlhJJo5SoK8DxtuE=;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Feedback-ID:
 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
 Subject:From;
 b=AcQKiMCxQUIAeBH7dfLDpDZq/kNVQUxxH+imVfuCGpYYGYnOA0XEj6Y/0gE8frYsC
 JraFLRnt5w8o+slNa6aqblHfTyK8m4DQWFTemrAnLSgTPLPojmiw/ZKzgrynbRo2De
 5mys8E34LNI8ee3Lrj0FWf0pyfJqKg/DE2j4Df4T96XUmstTOBCGkbdIpCfEb8fjhG
 Esbnxy0zrFDpZUO7CmLWwdf5xlWKU695JzuDxkwjoKbFBgT6JemD2PsCVhcTZ1N9FK
 HZerd7EA+dDIetd8cS52ITLEWdbIVF0AJfJnOhkp4sPytYG/oh0AqWmAYJApDUxZH8
 whUbyP6XOadAw==
Received: from pmta10.mandrill.prod.suw01.rsglab.com (localhost [127.0.0.1])
 by mail186-12.suw21.mandrillapp.com (Mailchimp) with ESMTP id
 4fLc755b0Sz705b0b
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 14:15:13 +0000 (GMT)
From: "Anthony PERARD" <anthony.perard@vates.tech>
Subject: =?utf-8?Q?Re:=20[PATCH=205/5]=20accel/xen:=20Build=20without=20target-specific=20knowledge?=
Received: from [37.26.189.201] by mandrillapp.com id
 03d8c58766eb4205ae529e497ec5d511; Wed, 25 Feb 2026 14:15:13 +0000
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1772028911983
To: "=?utf-8?Q?Philippe=20Mathieu-Daud=C3=A9?=" <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 "Pierrick Bouvier" <pierrick.bouvier@linaro.org>,
 "Paolo Bonzini" <pbonzini@redhat.com>, xen-devel@lists.xenproject.org,
 "Stefano Stabellini" <sstabellini@kernel.org>,
 "Anthony PERARD" <anthony@xenproject.org>, "Paul Durrant" <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-Id: <aZ8D77iyFtqyGF18@l14>
References: <20260225051303.91614-1-philmd@linaro.org>
 <20260225051303.91614-6-philmd@linaro.org>
In-Reply-To: <20260225051303.91614-6-philmd@linaro.org>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,
 =20including=20all=20headers,
 =20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.03d8c58766eb4205ae529e497ec5d511?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20260225:md
Date: Wed, 25 Feb 2026 14:15:13 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=198.2.186.12;
 envelope-from=bounce-md_30504962.699f03f1.v1-03d8c58766eb4205ae529e497ec5d511@bounce.vates.tech;
 helo=mail186-12.suw21.mandrillapp.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Feb 25, 2026 at 06:13:03AM +0100, Philippe Mathieu-Daud=C3=A9 wrote=
:
> Code in accel/ aims to be target-agnostic. Enforce that
> by moving the MSHV file units to system_ss[], which is

You mean Xen    ^ here ?

> target-agnostic.
> 
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

In anycase, it seems to works fine for me:
Acked-by: Anthony PERARD <anthony.perard@vates.tech>

Thanks,


--
Anthony Perard | Vates XCP-ng Developer

XCP-ng & Xen Orchestra - Vates solutions

web: https://vates.tech



