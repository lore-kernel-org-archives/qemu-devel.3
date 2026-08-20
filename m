Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D14CFC5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 13:25:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx2la-0002AZ-V8; Thu, 20 Aug 2026 09:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wx2lR-0001ze-2x
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 09:25:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wx2lP-0003Y9-M0
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 09:25:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787232299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sFByP3s/oCdg8p5yw/JMsBs4NFIQsSIjPj9cggUt8xY=;
 b=KzXy+aSYvd6GPxyPij22pqUTMA8LXFEVFHE0UrYCCH2farxFhx2zIjo9bYOIBPuedwkrJS
 5OTDvruEtBV4kZy7oQLW0Y5GzNcy0YAsPT6AcWIzbsnju3w4m5J1923BoJHtRx+mVZUZy0
 T0NY6nsco5SoAj/UikXgq/jGQl4y2qY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-297-ah6WAvugMK2e6ykPbzEC6A-1; Thu,
 20 Aug 2026 09:24:42 -0400
X-MC-Unique: ah6WAvugMK2e6ykPbzEC6A-1
X-Mimecast-MFC-AGG-ID: ah6WAvugMK2e6ykPbzEC6A_1787232281
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E17E195609D; Thu, 20 Aug 2026 13:24:40 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E43151955F03; Thu, 20 Aug 2026 13:24:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [RFC PATCH 09/13] cpus: Add const-qualified CPU environment
 accessors
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org, 
 qemu-riscv@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 qemu-arm@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Zhao Liu <zhao1.liu@intel.com>
In-Reply-To: <20260820104730.25462-10-philmd@oss.qualcomm.com>
References: <20260820104730.25462-1-philmd@oss.qualcomm.com>
 <20260820104730.25462-10-philmd@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 17:22:15 +0400
Message-Id: <178723213510.2730041.7821114645220672277.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=364;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=1Y4eR6xT+UVwuZ8lWFhL0cA0oBvVByqDoawqwtOtDUE=;
 b=kA0DAAoB2ujhCXWWnOUByyZiAGqG/+qjJC2VcSciZG6cauZg/tEsAfJ9KcNdnHaVsaFuXx3Jc
 okCMwQAAQoAHRYhBIepvZM/h8YG0nb2Ldro4Ql1lpzlBQJqhv/qAAoJENro4Ql1lpzloTUQAJLI
 H77BWf7E6zi81d2beeHDzlpveOw43GNthVKaS4OJZYfPntM/okTBpMHz25NczCjwLUUeMtVXIB2
 QZnC+z0c7VJXQzX/8VArt9grqChtZZOeFjEa5ufwY8WrCmpXjII6Wk0ceiNTmbZZUqFoZKTjDfk
 SRyLk0CdRet9VikkOKzkZubj3laeTrEEdfjJ7LA2OkMkuxUquf5COD5A3W2+zUPLIF0Biwd5AcZ
 ++U17wIlQMYd3LvOUi23JukwIjXwzSRVQ6VZ3kwG0ReUxPhDzmf0fTm8b0FmQWfe73gfD7h5n/b
 O7lRfaQE5zu6yRqNX7dRh8RpzfW2vXx+uH9DWcCHgqtRUzwP/9P1zXTwYk91yuGLVHVOrvmcYyX
 yERpSONqvQPgBNaOUedAIlBkUZU+c5TG7Rbk0p5C/mByYf1ULGSvB9Pb2EP1MGpTXp7kuDeuWqm
 2Lbw1ncjS86KJn32ZfyRCStvRJobyL4EbkcAYXBnKlsZ2OS6PDkGqMHfbtaZmzlQC4DrK8MkXPW
 BooUxXvImC9AqqPX1tK43rAgoPZb3aXau/owpTNfqW1S1K3vmoIW9StGkbwXQMwsH8vm4pgidoU
 9sM2kiuigaCWTArG/PdUfpeQo1KH7QrmXlXIxOfzsNQpS0ciN8vIBeAJpZMHeHJTsZ3dTujs9Kj
 U/hUs
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

On Thu, 20 Aug 2026 12:47:25 +0200, Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> wrote:
> Introduce const-qualified variants of cpu_env() and
> env_archcpu(), to safely access CPU architecture
> state when it should not be modified.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


