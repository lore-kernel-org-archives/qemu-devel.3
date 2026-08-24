Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A9EFC5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 07:40:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyPH4-0006Sf-57; Mon, 24 Aug 2026 03:39:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyPH3-0006SS-2X
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 03:39:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyPH1-0006F9-NO
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 03:39:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787557155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mjNqYoOpghtIcEYV4qXV0PkejQ1l3mG/pYLaLGHR+Fc=;
 b=N5shKF2Am9EUfSFgqkpMqEG1C6YFHpIjTsd6OEcE7cEr+xSsCe6uUiuzw8Y2jIwE8izckX
 FtYyFDXfd6NyXEV2NPzOaikEZRCGFb0Q+ULwgxxE1/lpJobpeuemKU/RYb182b+FsBKVGJ
 BpMxH5SCqPm7moujfwj/CTzLaERvQ0A=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-34-x3la_NwVNxWqQrPJ-8qSpA-1; Mon,
 24 Aug 2026 03:39:11 -0400
X-MC-Unique: x3la_NwVNxWqQrPJ-8qSpA-1
X-Mimecast-MFC-AGG-ID: x3la_NwVNxWqQrPJ-8qSpA_1787557150
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D61F41944E42; Mon, 24 Aug 2026 07:39:09 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E538E1955F09; Mon, 24 Aug 2026 07:39:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 05/12] python: upgrade to Python3.12+
From: marcandre.lureau@redhat.com
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Cleber Rosa <crosa@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260824052859.880475-6-jsnow@redhat.com>
References: <20260824052859.880475-1-jsnow@redhat.com>
 <20260824052859.880475-6-jsnow@redhat.com>
Date: Mon, 24 Aug 2026 11:38:46 +0400
Message-Id: <178755712685.3526866.4012813319743126227.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=660;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=tTRhzaWBeGQyUypy3m3Oll1zGYXDwy/gBYYtLVXGGO0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqi/UJLo+qEMsz9+cTvsw5UUUU5XOfclsoQ1ZAj
 WZC6c/MG1aJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaov1CQAKCRDa6OEJdZac
 5V7ED/9Re3G+ysbLbQtCA8jCFPMEcfFdD/l4j99gGlnastl5dnDnF+Off5aSEj++9DyEZPtjuU/
 aL6b94d0vB7LgIlTDqwB1Fr/oFzoaCC6pUCoNnRLc5pawiqFEv4kPaSWB+drDJWyrToLo8bYJuT
 smzb3mu4pP2c1WPLspE0jRvdvG5G8tHPYUc4jC4dfop3OrxAuvmh917ZMrdgja2PzClg3ZMTAR9
 pB+EE8tJJtfij30EPlZwrgPtGoJp4YJVNmA5GdQwLjqbDyDu2/fRhnqHf9N8Hh7V9u0LPEUMl9q
 huxefzqWvdQGkDnHcf0BsWIIU4Rlhb6q9to/4g26/N0ZDqioVWfSUKYMZ0pB5ZjnGN4zaumbMDP
 bc+Swo1MVX/SSLHOYRz++h6z8X0bRfAyaos6FkP1po4BM1BEdnC6uflWFP4f9Oj1gIRk5/xfufH
 vcFiJQtwm3WQnW0vAINZTNZfHUNB0cjzT1i/VmsLC1xKl9yMzD7yePEoReMDhrhGYP9h10HK2Od
 WbK1l2q0C99uOfWcIpEj1YFXoORmj8Xe1tXNWOJhVJr/vudaw48MYe4ttt20hcmf+lS/9tlzYLN
 VEAr9I2fMZVg7NKTWr3VluOwHdEUwMj99d8jPrUERoBcOqQXShJUZcdNQvNt4qCOmhHy96TUQvV
 OMm8tjlJDOsVJqg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, 24 Aug 2026 01:28:51 -0400, John Snow <jsnow@redhat.com> wrote:
> With Python3.9 EOL and Python3.10 soon to be EOL (October 2026), and
> with ... no other supported build platform actually using Python 3.11,
> require the use of Python3.12 or later.
> 
> Additionally, as part of this upgrade, remove the use of tomllib from
> mkvenv as it is now standard in the Python stdlib: leaving this
> transitional code in causes a regression with mypy which becomes
> confused about the overloaded use of 'tomllib'.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


