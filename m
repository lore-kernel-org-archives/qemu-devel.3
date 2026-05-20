Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44499CD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 13:45:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPhEL-0003KN-Oi; Wed, 20 May 2026 09:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wPhEH-0003K7-N9
 for qemu-devel@nongnu.org; Wed, 20 May 2026 09:44:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wPhEC-0001U1-LQ
 for qemu-devel@nongnu.org; Wed, 20 May 2026 09:44:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779284689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VK11SFi97RGlhHH39Qm0PWWU9Odl1zMnVNwoa7+wwKU=;
 b=YBwq4FWgNU07vOJp2Q17JMVYorLDNUoSha0+1BmNbWe03hEMbMiRbkV6W/PLhFePirtTi0
 5UteUjGxk3rf4H/6plXiD+4uqW1Rtq77nvW/xgNQ+gO+kyEYPh9GFqAfekjF6Rb14MDecJ
 uLv4nETiTeOWyKPPxwXR6BK4XZtImEI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-dQSOoM7yO6iy06Oj3ZnAXg-1; Wed,
 20 May 2026 09:44:45 -0400
X-MC-Unique: dQSOoM7yO6iy06Oj3ZnAXg-1
X-Mimecast-MFC-AGG-ID: dQSOoM7yO6iy06Oj3ZnAXg_1779284684
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 833E11800359; Wed, 20 May 2026 13:44:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0CC51180075D; Wed, 20 May 2026 13:44:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BE69721E6A01; Wed, 20 May 2026 15:44:41 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Brian Cain
 <brian.cain@oss.qualcomm.com>
Subject: Re: [PATCH] MAINTAINERS: Fix hexagon-linux-user.mak path
In-Reply-To: <87fr3mkz26.fsf@pond.sub.org> (Markus Armbruster's message of
 "Wed, 20 May 2026 15:09:21 +0200")
References: <20260520123947.12711-1-philmd@linaro.org>
 <87fr3ms0oi.fsf@pond.sub.org>
 <f52ebf28-1921-4ada-a7c5-ec3342cd3acb@linaro.org>
 <57f7a25a-dce1-452f-8529-187d66a6d8de@linaro.org>
 <87fr3mkz26.fsf@pond.sub.org>
Date: Wed, 20 May 2026 15:44:41 +0200
Message-ID: <87se7mjiuu.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Markus Armbruster <armbru@redhat.com> writes:

> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>
>> On 20/5/26 14:57, Philippe Mathieu-Daud=C3=A9 wrote:

[...]

>>> Oh :( I already sent various patches about that yesterday :(
>
> I've been picking them into my tree as I went.  I may have missed the
> odd patch, but I'll fix that.

Right now I have

Philippe Mathieu-Daud=C3=A9 (9):
      MAINTAINERS: Fix docker/dockerfiles/debian-hexagon-cross.docker path
      MAINTAINERS: Cover debian-loongarch-cross.docker with LoongArch secti=
on
      MAINTAINERS: Cover debian-xtensa-cross.docker with Xtensa section
      MAINTAINERS: Cover debian-tricore-cross.docker with TriCore section
      MAINTAINERS: Cover python.docker with Python library section
      MAINTAINERS: Fix hexagon-linux-user.mak path
      MAINTAINERS: Correct scripts/coverity-model.c path
      MAINTAINERS: Fix s390x storage key/attribute device paths
      MAINTAINERS: Fix tcg/s390x/ path

and about three dozen of my own.  Am I missing any of yours?


