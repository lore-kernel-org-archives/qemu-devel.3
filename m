Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 118E7CD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 11:32:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbcsu-000095-Iv; Mon, 22 Jun 2026 07:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wbcsl-00008U-Q8
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 07:32:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wbcsj-0003Xw-ON
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 07:32:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782127918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nQTLCoerw2g6m519qx6gUOD5vx78/Ohag7QOIFYVCbs=;
 b=Tiu+7DrvpST3+Z632O4JDLWSmAW3Pu7toizhg3x8uo136hz9yhD519tekKDtzEiGtBJE/P
 djR1JOBowwSUE1eHiPtnVRMBWnDs31Dv4B82LqFCEujisRA5dqwxIQnTlpNYqG3jp2F+xP
 YDzEfjdyS399zm1fDB5wG2OEOPcDxb4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-156-oTdOEz_oNyiScL8dmXKwKQ-1; Mon,
 22 Jun 2026 07:31:56 -0400
X-MC-Unique: oTdOEz_oNyiScL8dmXKwKQ-1
X-Mimecast-MFC-AGG-ID: oTdOEz_oNyiScL8dmXKwKQ_1782127915
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7CBB51955DB0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 11:31:55 +0000 (UTC)
Received: from berrange.com (unknown [10.44.33.119])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5A1EC195394E; Mon, 22 Jun 2026 11:31:53 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 0/3] Record maintainer/reviewer Git Lab handles
Date: Mon, 22 Jun 2026 12:31:49 +0100
Message-ID: <20260622113152.1710585-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When triaging GitLab issues, whether regular bugs or security
disclosures, we need to be able to assign suitable accounts.

We can only assign Git Lab handles for accounts that are members
of the QEMU group, or QEMU repository with the "Reporter" role
or higher.

Currently one needs to run 'get_maintainer.pl -f <file>' to get
the maintainer / reviewer names & emails, and then look in the
GitLab members page to see if there is a match.

This simplifies that by adding a "--gitlab" option to the
get_maintainer.pl script that will report the GitLab handle
for maintainers / reviewers too.

MAINTAINERS is then updated with all known accounts.

Ignoring bot accounts, there are the following GitLab accounts
for people whom are not in MAINTAINERS as a Reviewer/Maintainer:

    Aihua Liang (aliang1)
    Anthony Roberts (anthony-linaro)
    Bastian Koppelmann (kbastian-qemu)
    Eduardo Habkost (ehabkost)
    Eldon (eldondev)
    Emilio Cota (cota_)
    Jim MacArthur (jmacarthur)
    Joaquin de Andres (xcancerberox)
    Juan Quintela (juan.quintela)
    Paul Zimmerman (pauldzim)
    Peter Krempa (pipo.sk)
    Peter Krempa (work) (pkrempa)

Much more significantly, there are the following people present
in MAINTAINERS, whom are not members of the GitLab project:

    Aditya Gupta <adityag-#-linux-#-ibm-#-com>
    Akihiko Odaki <odaki-#-rsg-#-ci-#-i-#-u-tokyo-#-ac-#-jp>
    Albert Esteve <aesteve-#-redhat-#-com>
    Alberto Garcia <berto-#-igalia-#-com>
    Alejandro Jimenez <alejandro-#-j-#-jimenez-#-oracle-#-com>
    Aleksandar Rikalo <arikalo-#-gmail-#-com>
    Alessandro Di Federico <ale-#-rev-#-ng>
    Alexandre Iooss <erdnaxe-#-crans-#-org>
    Alexandre Ratchov <alex-#-caoua-#-org>
    Alexey Kardashevskiy <aik-#-ozlabs-#-ru>
    Amit Shah <amit-#-kernel-#-org>
    Andrew Jeffery <andrew-#-codeconstruct-#-com-#-au>
    Anthony PERARD <anthony-#-xenproject-#-org>
    Anton Johansson <anjo-#-rev-#-ng>
    Antony Pavlov <antonynpavlov-#-gmail-#-com>
    Ari Sundholm <ari-#-tuxera-#-com>
    Artyom Tarasenko <atar4qemu-#-gmail-#-com>
    Aurelien Jarno <aurelien-#-aurel32-#-net>
    BALATON Zoltan <balaton-#-eik-#-bme-#-hu>
    Ben Chaney <bchaney-#-akamai-#-com>
    Bernhard Beschow <shentey-#-gmail-#-com>
    Bibo Mao <maobibo-#-loongson-#-cn>
    Brad Smith <brad-#-comstyle-#-com>
    Canokeys.org <contact-#-canokeys-#-org>
    Chao Liu <chao-#-liu-#-zevorn-#-gmail-#-com>
    Chinmay Rath <rathc-#-linux-#-ibm-#-com>
    Christoph Muellner <christoph-#-muellner-#-vrull-#-eu>
    Clément Chigot <chigot-#-adacore-#-com>
    Clément Mathieu--Drif <clement-#-mathieu--drif-#-bull-#-com>
    Collin Walling <walling-#-linux-#-ibm-#-com>
    Corey Minyard <cminyard-#-mvista-#-com>
    Denis V. Lunev <den-#-openvz-#-org>
    Dmitry Fleytman <dmitry-#-fleytman-#-gmail-#-com>
    Dmitry Osipenko <dmitry-#-osipenko-#-collabora-#-com>
    Dorjoy Chowdhury <dorjoychy111-#-gmail-#-com>
    Doru Blânzeanu <dblanzeanu-#-linux-#-microsoft-#-com>
    Edgar E. Iglesias <edgar-#-iglesias-#-gmail-#-com>
    Elena Ufimtseva <elena-#-ufimtseva-#-oracle-#-com>
    Eric Auger <eric-#-auger-#-redhat-#-com>
    Eric Farman <farman-#-linux-#-ibm-#-com>
    Eugenio Pérez <eperezma-#-redhat-#-com>
    Farhan Ali <alifm-#-linux-#-ibm-#-com>
    Felipe Balbi <balbi-#-kernel-#-org>
    Francisco Iglesias <francisco-#-iglesias-#-amd-#-com>
    Frederic Konrad <konrad-#-frederic-#-yahoo-#-fr>
    Gaurav Sharma <gaurav-#-sharma_7-#-nxp-#-com>
    Gautam Gala <ggala-#-linux-#-ibm-#-com>
    Gautam Menghani <gautam-#-linux-#-ibm-#-com>
    Giuseppe Lettieri <g-#-lettieri-#-iet-#-unipi-#-it>
    Glenn Miles <milesg-#-linux-#-ibm-#-com>
    Gonglei <arei-#-gonglei-#-huawei-#-com>
    Haixu Cui <quic_haixcui-#-quicinc-#-com>
    Halil Pasic <pasic-#-linux-#-ibm-#-com>
    Hao Wu <wuhaotsh-#-google-#-com>
    Hari Bathini <hbathini-#-linux-#-ibm-#-com>
    Hendrik Brueckner <brueckner-#-linux-#-ibm-#-com>
    Hervé Poussineau <hpoussin-#-reactos-#-org>
    Hongren (Zenithal) Zheng <i-#-zenithal-#-me>
    Huacai Chen <chenhuacai-#-kernel-#-org>
    Hyman Huang <infra-#-ai-#-cloud-#-bitdeer-#-com>
    Ilya Dryomov <idryomov-#-gmail-#-com>
    Ilya Leoshkevich <iii-#-linux-#-ibm-#-com>
    Ilya Maximets <i-#-maximets-#-ovn-#-org>
    Jagannathan Raman <jag-#-raman-#-oracle-#-com>
    Jamin Lin <jamin_lin-#-aspeedtech-#-com>
    Jan Kiszka <jan-#-kiszka-#-web-#-de>
    Jared Rossi <jrossi-#-linux-#-ibm-#-com>
    Jason Herne <jjherne-#-linux-#-ibm-#-com>
    Jean-Christophe Dubois <jcd-#-tribudubois-#-net>
    Jesper Devantier <foss-#-defmacro-#-it>
    Jeuk Kim <jeuk20-#-kim-#-samsung-#-com>
    Jiaxun Yang <jiaxun-#-yang-#-flygoat-#-com>
    Jiri Pirko <jiri-#-resnulli-#-us>
    Jiri Slaby <jslaby-#-suse-#-cz>
    Joe Komlodi <komlodi-#-google-#-com>
    Joel Stanley <joel-#-jms-#-id-#-au>
    John Levon <john-#-levon-#-nutanix-#-com>
    Jonathan Cameron <jic23-#-kernel-#-org>
    Kane Chen <kane_chen-#-aspeedtech-#-com>
    Kashyap Chamarthy <kchamart-#-redhat-#-com>
    Keith Busch <kbusch-#-kernel-#-org>
    Kohei Tokunaga <ktokunaga-#-mail-#-gmail-#-com>
    Kuan-Wei Chiu <visitorckw-#-gmail-#-com>
    Kyle Evans <kevans-#-freebsd-#-org>
    LIU Zhiwei <zhiwei_liu-#-linux-#-alibaba-#-com>
    Leif Lindholm <leif-#-lindholm-#-oss-#-qualcomm-#-com>
    Li Zhijian <lizhijian-#-fujitsu-#-com>
    Li-Wen Hsu <lwhsu-#-freebsd-#-org>
    Liu Zhiwei <zhiwei_liu-#-linux-#-alibaba-#-com>
    Luc Michel <luc-#-lmichel-#-fr>
    Lukas Straub <lukasstraub2-#-web-#-de>
    Maciej S. Szmigiero <maciej-#-szmigiero-#-oracle-#-com>
    Mads Ynddal <mads-#-ynddal-#-dk>
    Magnus Kulke <magnuskulke-#-linux-#-microsoft-#-com>
    Maksim Davydov <davydov-max-#-yandex-team-#-ru>
    Marcelo Tosatti <mtosatti-#-redhat-#-com>
    Mark Kanda <mark-#-kanda-#-oracle-#-com>
    Markus Armbruster <armbru-#-redhat-#-com>
    Mathieu Poirier <mathieu-#-poirier-#-linaro-#-org>
    Matthew Rosato <mjrosato-#-linux-#-ibm-#-com>
    Mauro Carvalho Chehab <mchehab+huawei-#-kernel-#-org>
    Max Filippov <jcmvbkbc-#-gmail-#-com>
    Michael Rolnik <mrolnik-#-gmail-#-com>
    Milan Zamazal <mzamazal-#-redhat-#-com>
    Nabih Estefan <nabihestefan-#-google-#-com>
    Niek Linnenbank <nieklinnenbank-#-gmail-#-com>
    Ninad Palsule <ninad-#-linux-#-ibm-#-com>
    Palmer Dabbelt <palmer-#-dabbelt-#-com>
    Patrick Leis <venture-#-google-#-com>
    Paul Durrant <paul-#-xen-#-org>
    Pavel Pisa <pisa-#-cmp-#-felk-#-cvut-#-cz>
    Pedro Barbuda <pbarbuda-#-microsoft-#-com>
    Peter Lieven <pl-#-dlhnet-#-de>
    Peter Xu <peterx-#-redhat-#-com>
    Phil Dennis-Jordan <phil-#-philjordan-#-eu>
    Philipp Tomsich <philipp-#-tomsich-#-vrull-#-eu>
    Ran Wang <wangran-#-bosc-#-ac-#-cn>
    Raphael Norwitz <rnorwitz-#-nvidia-#-com>
    Reinoud Zandijk <reinoud-#-netbsd-#-org>
    Richard W.M. Jones <rjones-#-redhat-#-com>
    Roman Bolshakov <rbolshakov-#-ddn-#-com>
    Sai Pavan Boddu <sai-#-pavan-#-boddu-#-amd-#-com>
    Sairaj Kodilkar <sarunkod-#-amd-#-com>
    Samuel Tardieu <sam-#-rfc1149-#-net>
    Samuel Thibault <samuel-#-thibault-#-ens-lyon-#-org>
    Sergio Lopez <slp-#-redhat-#-com>
    Song Gao <gaosong-#-loongson-#-cn>
    Sourabh <sourabhjain-#-linux-#-ibm-#-com>
    Sourabh Jain <sourabhjain-#-linux-#-ibm-#-com>
    Sriram Yagnaraman <sriram-#-yagnaraman-#-ericsson-#-com>
    Stafford Horne <shorne-#-gmail-#-com>
    Stefano Stabellini <sstabellini-#-kernel-#-org>
    Steven Lee <steven_lee-#-aspeedtech-#-com>
    Strahinja Jankovic <strahinja-#-p-#-jankovic-#-gmail-#-com>
    Subbaraya Sundeep <sundeep-#-lkml-#-gmail-#-com>
    Sunil V L <sunilvl-#-ventanamicro-#-com>
    Sven Schnelle <svens-#-stackframe-#-org>
    Tao Tang <tangtao1634-#-phytium-#-com-#-cn>
    Thanos Makatos <thanos-#-makatos-#-nutanix-#-com>
    Titus Rwantare <titusr-#-google-#-com>
    Tomita Moeko <tomitamoeko-#-gmail-#-com>
    Tony Krowiak <akrowiak-#-linux-#-ibm-#-com>
    Troy Lee <leetroy-#-gmail-#-com>
    Tyrone Ting <kfting-#-nuvoton-#-com>
    Vikram Garhwal <vikram-#-garhwal-#-bytedance-#-com>
    Viktor Prutyanov <viktor-#-prutyanov-#-phystech-#-edu>
    Vincenzo Maffione <v-#-maffione-#-gmail-#-com>
    Viresh Kumar <viresh-#-kumar-#-linaro-#-org>
    WANG Xuerui <git-#-xen0n-#-name>
    Wei Liu <wei-#-liu-#-kernel-#-org>
    Weiwei Li <liwei1518-#-gmail-#-com>
    Xie Yongji <xieyongji-#-bytedance-#-com>
    Yi Liu <yi-#-l-#-liu-#-intel-#-com>
    Yonggang Luo <luoyonggang-#-gmail-#-com>
    Yoshinori Sato <yoshinori-#-sato-#-nifty-#-com>
    Yuri Benditovich <ybendito-#-redhat-#-com>
    Zhang Chen <zhangckid-#-gmail-#-com>
    Zhao Liu <zhao1-#-liu-#-intel-#-com>
    Zhenzhong Duan <zhenzhong-#-duan-#-intel-#-com>
    Zhuoying Cai <zycai-#-linux-#-ibm-#-com>
    zhenwei pi <zhenwei-#-pi-#-linux-#-dev>

Plenty of those will have GitLab accounts, but are simply not members
of QEMU. Plenty more probably aren't registered with GitLab at all.

Short of emailing all of those people directly, I don't see a good
way to identify their GitLab accounts (if any), in order to invite
them to the QEMU project. I don't want to blindly invite accounts
which merely have the same name on GitLab as there's too much risk
of getting a mis-match.

Daniel P. Berrangé (3):
  get_maintainer: add ability to report Git Lab handle
  MAINTAINERS: record known Git Lab handles for all maintainers
  MAINTAINERS: record known Git Lab handles for all reviewers

 MAINTAINERS               | 396 ++++++++++++++++++++++++++++++++++++++
 scripts/get_maintainer.pl |  17 +-
 2 files changed, 411 insertions(+), 2 deletions(-)

-- 
2.54.0


