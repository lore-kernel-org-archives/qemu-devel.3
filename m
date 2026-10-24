Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB3E606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 13:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=alNncFKe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKbfm-0006NG-Lp; Sat, 24 Oct 2026 09:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xKbfT-0006Jh-No
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 09:20:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xKbfR-0000jH-IJ
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 09:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792848012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SgKf/WOG3XAMXo7tTfPXMaAu+1O+ZT47GuiM5eIewZ4=;
 b=alNncFKekVO2rplPcVgGOK6ENSVK/31FtT8pko8UA36YGuA67mTzM6JuZLeXnwJF71X43l
 FXVJx2s+iKKqUAauT7UxyUDhFfobppf2IIZp9ilDISnLFHu/BdNJ0wgl2S4e/0XK1JwZpQ
 boPJQEaw9qMK/ZUDVzCoMr0YQbjuczU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-45-a91jCxqFMaa16dqL2LWWxQ-1; Sat,
 24 Oct 2026 09:20:09 -0400
X-MC-Unique: a91jCxqFMaa16dqL2LWWxQ-1
X-Mimecast-MFC-AGG-ID: a91jCxqFMaa16dqL2LWWxQ_1792848006
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D7341955F61; Sat, 24 Oct 2026 13:20:05 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 964181956089; Sat, 24 Oct 2026 13:20:04 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 10/19] tests/guest-debug: add --kargs option to run-test
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
In-Reply-To: <20261019192704.3220373-11-alex.bennee@linaro.org>
References: <20261019192704.3220373-1-alex.bennee@linaro.org>
 <20261019192704.3220373-11-alex.bennee@linaro.org>
Date: Sat, 24 Oct 2026 17:19:42 +0400
Message-Id: <179284798274.974117.7739578688912849096.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=621;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=B+gzmeMNAtC59lyBwic+Mj9EZ4mtNA0LJmOdqOyvDUY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq3LBxscVbcJ0XGMT+GxlFdBDF0ATQ7ZRC55TRJ
 l4yAO84DqWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatywcQAKCRDa6OEJdZac
 5QvnD/9CC/SdUzL2w04GT+yTOJXl/5m0dTwnQ45pY8kivGaIqz2eUGswxC6XOZQyaLyh/w9SgCJ
 iW6NLDKTexct/FUUeU8pefRI4YwKLk5DmEjQV+zC8/B6oQm+uXuHC4p/IRj/o9DmS2UEeylQw6v
 0yO26TMVhIhxZBYO/78ZPyRx/HoEIBRt418odC5uqiVwkF7IjvNMZMd+7yEE+b+hyn32XiXAJAC
 T/j0ke24Q4Th3C8f/oK34sFhE3VTh8+AMW3yVKoB0JlCN9BfaZNXKJ1W6tJ6JIshl6p4/wRVCuR
 gsjxYVGX4u2Sj4M1sm1gqwb9u78VqTP+djUrzTNjLFH2hBUs5Yd8ZAa6bJgE4WcjHRo7ufiADoe
 JlYHrMaCMHbnEEBhSRHyLBC3mXrG672q6O0BkpIXFjF8XTpgVGRMj+A3ViA7D3Hi3ifrozJ2UNT
 BbwUyuZO2aq5BgjmprWNEZRVaei/krR52ujWOzEXqjtJ2b/kRIwaGiBhg7OkjBKB3vOys3wkwSW
 2+DV1uhv52ELg3fR+RnGOo9TyD4YYf7lt2n7exvrKSiRBhd+FgODyNFNS7G0btYf1sqZ1kP0IzH
 XBgTy9VMIIZK15jQ7ALqEDkvd+vWkl3Zuk1OFw4PPeGoXQGjLm2fCIdOJOt2xZJIVY9XpM/R/6f
 9K8cW6siz3xQtgg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, 19 Oct 2026 20:26:55 +0100, Alex Bennée <alex.bennee@linaro.org> wrote:
> When passing kernel arguments to QEMU with --append we need to take
> care that things are properly escaped. It's easier if we get the run
> script to do it for us that constructed the nested escaped --qargs.
> 
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Message-ID: <20260930164649.433573-11-alex.bennee@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


