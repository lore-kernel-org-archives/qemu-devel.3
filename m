Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED7FC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 12:36:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqARr-00071l-Lk; Thu, 06 Mar 2025 07:35:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tqARo-000715-Mx
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 07:35:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tqARm-0006Mu-7m
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 07:35:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741264528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=07NJoJQ9oDMHWhAIxBzqeJwOY2lKoJWO7gXZZZBgZPM=;
 b=fRGre+pqbuDZxGsYB6BYadW1hN8UkU8fFbDtyt2Mp9gPvEJsC3+GAakgOLx4vM9EdGy7Q3
 5E6SDOSgHdxIq/B6zzB2GojTtETD5vvYC+hEL4kAlty+XydAydRXXDLMqpm3MKeYDEQSxN
 BYsUDDkcsl/UAilz2721H1goJEKiQOA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-36-cZLuZrRsP2ijBKMusitGjw-1; Thu,
 06 Mar 2025 07:35:24 -0500
X-MC-Unique: cZLuZrRsP2ijBKMusitGjw-1
X-Mimecast-MFC-AGG-ID: cZLuZrRsP2ijBKMusitGjw_1741264523
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 733F918001E0; Thu,  6 Mar 2025 12:35:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2AB01180AF7A; Thu,  6 Mar 2025 12:35:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 99ADC21E675E; Thu, 06 Mar 2025 13:35:19 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Philippe =?utf-8?Q?Mat?=
 =?utf-8?Q?hieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>,  Thomas
 Huth <thuth@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH 00/57] docs: Add new QAPI transmogrifier
In-Reply-To: <20250305034610.960147-1-jsnow@redhat.com> (John Snow's message
 of "Tue, 4 Mar 2025 22:45:09 -0500")
References: <20250305034610.960147-1-jsnow@redhat.com>
Date: Thu, 06 Mar 2025 13:35:19 +0100
Message-ID: <87wmd272wo.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

When I eyeballed the previous iteration, I made a few observations[1].
Let's see what has changed.

} New table of contents shows one level, old two.  No objection; the
} navigation thingie on the left is more useful anyway.

No change.  Okay.

} The new generator elides unreferenced types.  Generally good, but two
} observations:
}=20
} * QapiErrorClass is unreferenced, but its members are mentioned in
}   Errors sections.  QapiErrorClass serves as better than nothing error
}   code documentation, but it's gone in the new doc.  So this is a minor
}   regression.  We can figure out what to do about it later.
}=20
} * Section "QMP errors" is empty in the new doc, because its entire
}   contents is elided.  I guess we should elide the section as well, but
}   it's fine to leave that for later.

Unreferenced types are back.  Okay; we can elide them later.

} Old doc shows a definition's since information like any other section.
} New doc has it in the heading box.  Looks prettier and uses much less
} space.  Not sure the heading box is the best place, but it'll do for
} now, we can always move it around later.

No change.

} The new doc's headings use "Struct" or "Union" where the old one uses
} just "Object".  Let's keep "Object", please.

Fixed.

} In the new doc, some member references are no longer rendered as such,
} e.g. @on-source-error and @on-target-error in BackupCommon's note.
} Another small regression.

Fixed.

} Union branches are busted in the new generator's output.  I know they
} used to work, so I'm not worried about it.

Fixed: "When TAG-MEMBER is VALUE; The members of BRANCH-TYPE."

The semicolon feels odd.  I'd use a colon there.  Or put the when at the
end like the old generator does: "The members of BRANCH-TYPE when
TAG-MEMBER is VALUE".

Side effects, I think:

* Members of explicit base types are no longer inlined.  Instead: "The
  members of BASE-TYPE."

* Members of explicit command / event argument types are no longer
  inlined.  Instead: "The members of ARG-TYPE."

Both fine for the initial version.

} The new doc shows the return type, the old doc doesn't.  Showing it is
} definitely an improvement, but we need to adjust the doc text to avoid
} silliness like "Returns: SnapshotInfo =E2=80=93 SnapshotInfo".

No change.  Can polish on top.

} The new doc shows Arguments / Members, Returns, and Errors in two-column
} format.  Looks nice.  But for some reason, the two columns don't align
} horizontally for Errors like they do for the others.  Certainly not a
} blocker of anything, but we should try to fix it at some point.

No change.  Fine to leave for later.

} The new doc doesn't show non-definition conditionals, as mentioned in
} the cover letter.  It shows definition conditionals twice.  Once should
} suffice.

No change.  You asked for advice, and I gave some[2].

} There's probably more, but this is it for now.

Again, this is it for now.



[1] Message-ID: <87wmds4tpk.fsf@pond.sub.org>
https://lore.kernel.org/qemu-devel/87wmds4tpk.fsf@pond.sub.org/

[2] Message-ID: <87zfhya0is.fsf@pond.sub.org>
https://lore.kernel.org/qemu-devel/87zfhya0is.fsf@pond.sub.org/


