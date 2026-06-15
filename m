Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F32CD98C5
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 14:11:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ81K-0007wo-Ty; Mon, 15 Jun 2026 10:10:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wZ81I-0007wS-JL
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 10:10:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wZ81F-0004zt-4a
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 10:10:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781532626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mrc6jxfXu0JVMA1XB7QC9Y7mwSTtUHRcwNNASjO+bCA=;
 b=QioRW5HL6NQt60XLAszISMc89A4NAKBbIXdZDHh5H4CtHVwIEzF3buFUOdL0W5YHYVKeAL
 1zkBibW0TCpri7sBd3YH8jz2WM9E2FhOmHPaR7T1fmnEdQUuwAC6ft1LQ3h7Xb9nTT27R2
 qIxBTUBx4GuzqQfj2yeK+PB4Fd5sXFY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-Be3Lvz_fOvOBe61wxVLBXA-1; Mon,
 15 Jun 2026 10:10:22 -0400
X-MC-Unique: Be3Lvz_fOvOBe61wxVLBXA-1
X-Mimecast-MFC-AGG-ID: Be3Lvz_fOvOBe61wxVLBXA_1781532620
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF8F218003FC; Mon, 15 Jun 2026 14:10:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EEF7118005AE; Mon, 15 Jun 2026 14:10:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 81EF521E6A01; Mon, 15 Jun 2026 16:10:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Ani Sinha <anisinha@redhat.com>,  Michael Roth
 <michael.roth@amd.com>,  Igor Mammedov <imammedo@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Eric Blake <eblake@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,  Mauro
 Carvalho Chehab
 <mchehab+huawei@kernel.org>,  "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Gerd Hoffmann <kraxel@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 linux-edac@vger.kernel.org, Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH v3 03/16] qapi/docs: remove unused QAPIDoc subsection
 members
In-Reply-To: <20260603032201.993015-4-jsnow@redhat.com> (John Snow's message
 of "Tue, 2 Jun 2026 23:21:48 -0400")
References: <20260603032201.993015-1-jsnow@redhat.com>
 <20260603032201.993015-4-jsnow@redhat.com>
Date: Mon, 15 Jun 2026 16:10:16 +0200
Message-ID: <87pl1rx5br.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

Uh, "qapi/docs:"?  Shouldn't this be "qapi/parser:"?

John Snow <jsnow@redhat.com> writes:

> All users of the QAPIDoc object should be iterating over all_sections
> and not grabbing arbitrary subsections, if possible. Remove the 'body'
> and 'sections' members, as they are no longer used.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi/parser.py | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> index c3cf33904ef..b33edbba74f 100644
> --- a/scripts/qapi/parser.py
> +++ b/scripts/qapi/parser.py
> @@ -732,8 +732,6 @@ def __init__(self, info: QAPISourceInfo, symbol: Optional[str] = None):
>          self.all_sections: List[QAPIDoc.Section] = [
>              QAPIDoc.Section(info, QAPIDoc.Kind.PLAIN)
>          ]
> -        # the body section
> -        self.body: Optional[QAPIDoc.Section] = self.all_sections[0]
>          # dicts mapping parameter/feature names to their description
>          self.args: Dict[str, QAPIDoc.ArgSection] = {}
>          self.features: Dict[str, QAPIDoc.ArgSection] = {}
> @@ -742,8 +740,6 @@ def __init__(self, info: QAPISourceInfo, symbol: Optional[str] = None):
>          self.errors: Optional[QAPIDoc.Section] = None
>          # "Since" section
>          self.since: Optional[QAPIDoc.Section] = None
> -        # sections other than .body, .args, .features
> -        self.sections: List[QAPIDoc.Section] = []
>  
>      def end(self) -> None:
>          for section in self.all_sections:
> @@ -766,7 +762,6 @@ def ensure_untagged_section(self, info: QAPISourceInfo) -> None:
>  
>          # start new section
>          section = self.Section(info, kind)
> -        self.sections.append(section)
>          self.all_sections.append(section)
>  
>      def new_tagged_section(
> @@ -790,7 +785,6 @@ def new_tagged_section(
>                  raise QAPISemError(
>                      info, "duplicated '%s' section" % kind)
>              self.since = section
> -        self.sections.append(section)
>          self.all_sections.append(section)
>  
>      def _new_description(


