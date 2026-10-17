Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 724E4CCA462
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 08:45:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI022-0002kn-B9; Sat, 17 Oct 2026 04:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xI01r-0002MI-Q4
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 04:44:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xI01q-0007E2-Ct
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 04:44:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792226670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S43D9PqsX/W1ZM79lbx39eRc5BuHVSSn0dreNo/MUHU=;
 b=Qa9wYEoo3Ou8r60B0u8+EDS8QnfTEvqM+p24rP/VWhhTweXQ+nlu+P2Lmsk4iVkyYAs6qU
 fShtqf9sCMxGWqamNFnjO8znrMy15dkxfg89Sske+EIV64xkF/wVTOgTtSO4G2w1YYIWgS
 AAdMdsFfkuirAdWaErgMvo7j86IQTFI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-255-wsjef4ciOZSqjutj83UFOg-1; Sat,
 17 Oct 2026 08:44:17 +0000
X-MC-Unique: wsjef4ciOZSqjutj83UFOg-1
X-Mimecast-MFC-AGG-ID: wsjef4ciOZSqjutj83UFOg_1792226656
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2507618004AD; Sat, 17 Oct 2026 08:44:16 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 42C821956089; Sat, 17 Oct 2026 08:44:14 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 23/23] dump: remove cpu_get_note_size
From: marcandre.lureau@redhat.com
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 anjo@rev.ng, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261016181410.191743-24-pierrick.bouvier@oss.qualcomm.com>
References: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
 <20261016181410.191743-24-pierrick.bouvier@oss.qualcomm.com>
Date: Sat, 17 Oct 2026 12:42:49 +0400
Message-Id: <179222656914.1619676.835139848918392958.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=356;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=SHa5aCgrj2sYmmCUVLe5zCnUOTWMDcvxlj5JsjxEvyA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq0zUNDTIqHIEJcOcAsU3AWlqhvFogKDiJ6qBWb
 BdhyzqCu6uJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatM1DQAKCRDa6OEJdZac
 5aUWEACG9izOQG7Fg9DAkVKbxxJbfLYU84JZ6wTjSmrSqSk4wnzAGbu3SHGuWMUyM17SKRth9bo
 WB1sQyrR/3/urWYkpm0eilTXVdz+QZxdur+wfhCyI7L/V7zSUWl1E1whdoUMpi9GriqVj/kuqpK
 K8nUs7+dfX7aeKCBYiQUcZCau/em6It2CwoSgt14gcUeSKpjiDUDAxbtjkA/zHSrTrHECTTh5Vs
 cg2lxdn+6k0BvnCv+omA94kQPQbm5k32gLpzH+vuPQitowyE35PMr4YIpIqrGXItPyXvDMIY3oR
 HF2U7R2tWc7f8u0xw7OSFlHO9gtDUbUZt232KhlSgIJHQhR/roX+nT5rPInMTiysMqBuu4+dSIe
 4+GrUbVTJcJAJU7EmpQTfsQwb9LzeJoTdCZvF5isBlS3jfDAcJz5K4jgBQYllRobN7Y5MJNYmhW
 rdFSjHPyjduO2kHf9VmOC5WW0pR1fkzzdfOxo6H7jW9BOgMxBbZ1xmqhz8dhO355IbiIQAU+OZh
 s3ZZRuEXWKuycevdh7ekcEM+E9sowPD9Jr2/a+oR7reuBRfWzrNSymhoKqTJu/f08lKJ4Z/KejG
 D7IpyPlb7wGTocHKj9eo2Az3OG9XG9C/YpQeHICxKBWbgmf7ZF3gAGhCMbom5POemoIuDPbhksj
 JGC8h0nV/+OK9TA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 16 Oct 2026 11:14:10 -0700, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
> Now that both cpu and the dump implementation use the SysemuCPUOps
> interface, we can remove cpu_get_note_size, including its stub.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


