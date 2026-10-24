Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967FC606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 13:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Weh7/w7G
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKbfR-0006I7-UH; Sat, 24 Oct 2026 09:20:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xKbfI-00069I-JC
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 09:20:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xKbfG-0000VQ-6h
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 09:20:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792847999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UQAn78vPWEXTirZf0lDhu6gpbpKqpdAp+lS6Rf8H9Go=;
 b=Weh7/w7GIuU+905Ov5J+LbblMN/ND347k596BFWyC/3ygMLFKSr8b8uCg98MhObFm0pCYg
 miKHu2SwxvsnKl/PHBbJj5nTQ0VcckXOI8ozgdkc2T92/4FOEjSjT2iTtsfsqqdiUUbkar
 O5OXCy+DuPuzFG3Ge6KL0YDdzT53hrk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-368-gGp9DRFHPOSzLZzhK-QuSw-1; Sat,
 24 Oct 2026 09:19:55 -0400
X-MC-Unique: gGp9DRFHPOSzLZzhK-QuSw-1
X-Mimecast-MFC-AGG-ID: gGp9DRFHPOSzLZzhK-QuSw_1792847992
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 76B921800767; Sat, 24 Oct 2026 13:19:51 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C0EE2472; Sat, 24 Oct 2026 13:19:47 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 03/19] .dir-locals: include QEMU code in PYTHONPATH
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, 
 Thomas Huth <th.huth+qemu@posteo.eu>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Peter Xu <peterx@redhat.com>, Warner Losh <imp@bsdimp.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, Keith Busch <kbusch@kernel.org>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Ani Sinha <anisinha@redhat.com>, 
 Anders Roxell <anders.roxell@linaro.org>, qemu-arm@nongnu.org, 
 Song Gao <gaosong@loongson.cn>, Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Brad Smith <brad@comstyle.com>, Brian Cain <brian.cain@oss.qualcomm.com>, 
 Halil Pasic <pasic@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Yoshinori Sato <yoshinori.sato@nifty.com>, Klaus Jensen <its@irrelevant.dk>, 
 John Snow <jsnow@redhat.com>
In-Reply-To: <20261019192704.3220373-4-alex.bennee@linaro.org>
References: <20261019192704.3220373-1-alex.bennee@linaro.org>
 <20261019192704.3220373-4-alex.bennee@linaro.org>
Date: Sat, 24 Oct 2026 17:19:42 +0400
Message-Id: <179284798267.974117.15393556178297449546.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=578;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=+BCH9Z5mi72LJRQQiI+wiipLZ10r6xp2UXzIrS0MH7o=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq3LBwPQxpHHYOlsWSa1wnMYpNNwBR4SikLPv0B
 72grWoCbJ2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatywcAAKCRDa6OEJdZac
 5fXOEACXn9STtHcGucUYh/53ncUXUamteDNxZb6I76VMHjln7vp+PnhTVURFKkq/5UgvhRaUIbW
 uwv2lSPCAloX7tiM7l6dELDAYH0GnAE3zsZWO6P0LrsG5DuOJi5ncw2jkz8R8Py1NrckkFnKZFw
 vtq1q0SBr0hTfFyD2m1BeFCW2iQw2FoNzK+f+Prcd3uDmnI0bF1uLruFGiB65Ob6yWlObNpfU+V
 0FMgKd/rPy+KrNUKt7Asr9fyrqi4S8LeHOexNvltPBiZh31ZuZ+bNL/EPiZ/7p3k3FzziWcpLiq
 8QWjAgM6fT9Qyt9aDePQ8z67fuVc66QouRmHSlsSl2YMratptakedYRAl5td0RGBqTFDTrTTjk0
 oWJC1w54ISLOXMO/84D1qYGyNmQ0WJP1QRbM/Tr+dHU5nB3TY4knreojfCDawMHfPC5gloNVvWR
 LpKkPBAu6lDwQuq/L9Mh5rYTgdL7FIsWcgfvTRN6rbjGGQ0mK91HmD7gK6iaME99hY60hAQy1zX
 VXKEVute4DImc8W1044Msx6J6cozydVu5s/pb1CmVbVdo3SwoJkwiE4kUWplyLPx4joFrlNqiYj
 qdDftXJhgS0OdqqYVFHBNPrEnzl9Qwl3MBdM/m7YjVkgR3XDOZzxLgeMyiazbvIoYDS7ryMgWzl
 9UUny4IlsnUDpRQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 19 Oct 2026 20:26:48 +0100, Alex Bennée <alex.bennee@linaro.org> wrote:
> When editing python code the linters tools have a hard time with our
> imports as they can't be found. To ease this we can expand a
> PYTHONPATH in .dir-locals so at least Emacs users can have less
> warnings in their editor.
> 
> I still get complaints from python-mypy about missing library stubs
> that mean it can't do proper type analysis though.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


