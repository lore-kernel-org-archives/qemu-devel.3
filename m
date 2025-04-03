Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6230EC3600C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 00:57:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0VMB-0001kn-RW; Thu, 03 Apr 2025 20:56:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <witalihaschyts@icloud.com>)
 id 1u0Try-00036I-CH
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:21:14 -0400
Received: from ci74p00im-qukt09081502.me.com ([17.57.156.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <witalihaschyts@icloud.com>)
 id 1u0Tru-0005CP-AD
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:21:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
 s=1a1hai; bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
 h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To:x-icloud-hme;
 b=iliA+eEson9LQxxRXN2s6btoqNMlZdEJHHbxsDUOY3symniZj/S27dOX0k3JE7fjr
 tL4r14VJDQlsYczhCop4OWF3sxW0/QH6e1GP09+Upy48eKHH2OAdEewWYjN9RBVETj
 aR4RXzgQ2SVujEGAfcwCKJJDI3b9oFFgRyfkKJjCpMwhCX8J3iA7wAXHm2YUiVpYvG
 QP/qaonHUBw3BIQSKCx7do6EQ+3/UfU58zY1aZYy5ojxGtNAsneuCjT4BtsmuAyW6f
 6rTbOuYsKsE28lyzWdVw3no3rlNf/0mzddAC26G80RW8Salpz/NvvjePcHUYhGt867
 7r1WSbYpTj0rw==
Received: from smtpclient.apple (ci77p00im-dlb-asmtp-mailmevip.me.com
 [17.57.156.26])
 by ci74p00im-qukt09081502.me.com (Postfix) with ESMTPSA id 14891284023C;
 Thu,  3 Apr 2025 23:20:57 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: witalihaschyts@icloud.com
Mime-Version: 1.0 (1.0)
Date: Thu, 3 Apr 2025 18:20:34 -0500
Subject: Re: [PATCH v6 41/60] hw/i386: add option to forcibly report edge
 trigger in acpi tables
Message-Id: <322E5E0C-81B9-4DAD-8029-31BC02FA82D3@icloud.com>
Cc: anisinha@redhat.com, armbru@redhat.com, berrange@redhat.com,
 cohuck@redhat.com, eblake@redhat.com, imammedo@redhat.com, kvm@vger.kernel.org,
 marcel.apfelbaum@gmail.com, mst@redhat.com, mtosatti@redhat.com,
 pbonzini@redhat.com, philmd@linaro.org, qemu-devel@nongnu.org,
 richard.henderson@linaro.org, rick.p.edgecombe@intel.com, riku.voipio@iki.fi, 
 wangyanan55@huawei.com, zhao1.liu@intel.com
To: xiaoyao.li@intel.com
X-Mailer: iPhone Mail (22F5042g)
X-Proofpoint-ORIG-GUID: 0nZeRHqui77-FwEKk6YlLfqqkkz5ZOnU
X-Proofpoint-GUID: 0nZeRHqui77-FwEKk6YlLfqqkkz5ZOnU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_10,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 clxscore=1011
 suspectscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=662
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2504030124
Received-SPF: pass client-ip=17.57.156.5;
 envelope-from=witalihaschyts@icloud.com; helo=ci74p00im-qukt09081502.me.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 PYZOR_CHECK=1.392, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 03 Apr 2025 20:56:25 -0400
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


Sent from my iPhone

