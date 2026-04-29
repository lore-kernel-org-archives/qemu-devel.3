Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD232FF8867
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 08:37:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI0PA-0004Nw-PN; Wed, 29 Apr 2026 04:36:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wI0P8-0004Nb-LN
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 04:36:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wI0P7-0007vq-AY
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 04:36:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777451779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CvkgkDU8eyPhJS90HkNUWIRQIR/JNcDRVsIL7B7ZgfU=;
 b=PlA3OZPZHmGcIk++RAPZ7FdtC6BPp4wodLXi7IDqV5cTdBraFT1H7WXVTxzhC+G7+BVq7g
 LS+tdVxtZEUxAJfrtVfT1wpT2TWeBo/+mx6KPSW0XDMk6O8ubLPnb47jGI9+3MPp4nDjXJ
 fLaTqlvrZwiGsdRYizgJdxOt4xqcSgk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-371-rv0PiKgJPLOv7YbMh7jRcA-1; Wed,
 29 Apr 2026 04:36:14 -0400
X-MC-Unique: rv0PiKgJPLOv7YbMh7jRcA-1
X-Mimecast-MFC-AGG-ID: rv0PiKgJPLOv7YbMh7jRcA_1777451773
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C962A195606B; Wed, 29 Apr 2026 08:36:12 +0000 (UTC)
Received: from localhost (unknown [10.44.22.34])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2D93C300019F; Wed, 29 Apr 2026 08:36:10 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/6] target-info: extract target_info() definition in
 target-info-init.h
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Anton Johansson <anjo@rev.ng>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20260428234519.1812371-2-pierrick.bouvier@oss.qualcomm.com>
References: <20260428234519.1812371-1-pierrick.bouvier@oss.qualcomm.com>
 <20260428234519.1812371-2-pierrick.bouvier@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 12:36:03 +0400
Message-Id: <177745176381.2166241.4961064329506981583.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=320;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ZW6dprc2wm4d0+s1RxGeGoveen0ott0TgnIRojVRjEI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp8cL3hE6h5qb0ySXWNLbA28KwEP4n14KZxpiRC
 Es/1wuZwByJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafHC9wAKCRDa6OEJdZac
 5TCzEACt6w1vzwk4ptY5pp8lm6TMWsBK+J3N7C8Ux8Kp4f0kiC9hvVJz51d7cGhecgne7XcgRBA
 4UnQkB191Jfv9Qdg8sAc43L5GoCerUSqlmojdv9naY9apYCa2gQQ1AcukdAtfon3oXCz0xLqanF
 MmlrQB1ptjXuJyUD8+agGdZvGHQJf39BHvPnBxtLo1k4FFSJKCPPCdULoMcPIKwyJGARNOVNuL3
 Q6FVStgO3zBFSBc6zyivYOt82G3BiHOXW910j+0tSEeAzNMf2BLAp2tpENr6sp1XaBTpfJbIqIp
 yP72ejCeZv/4NtqebaBgzJTbW7fkKF8DPlq6tenduNkPP2S8+5qVga1UZn2c3AOzo8mNXJ8jEKB
 pKoJW1Im23n+4pyn6efuUgDv1BTBRQAemJ6xFyYrDJEdCIViPLMifCOYIUgZqI0g4zO4Q9EFXoJ
 O902RW9PEgOlTd/QkpHgfVrO6fiXu0655okvJszy8KUn2JCOZRAiRWBTtBpn1TMiRtULSpgCrWk
 +BkTJ7tcTSGJ2W/+hGeO/zn9BzurVKebIfr1wDprrRTBwz+K11nyJu0fwoEc7jyDKKtiAXf00KO
 7AF3TkWj+joMThgZfAA8KumPbgfA+xXLAjlPO5doAV5wWdXq7FmZX125jTKMofnb9hlhmZXThug
 asaPd+csp4vuJzg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.109,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

On Tue, 28 Apr 2026 16:45:14 -0700, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
> This allows us to prepare next commits, which will introduce qom
> registration for system mode.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


