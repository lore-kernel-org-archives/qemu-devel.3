Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8062CCAC5A5
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 19:53:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v194I-00083f-1d; Tue, 23 Sep 2025 15:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=8361951d9f=erick.shepherd@ni.com>)
 id 1v188M-0000fl-7V
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 14:53:02 -0400
Received: from mx0b-00300601.pphosted.com ([148.163.142.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=8361951d9f=erick.shepherd@ni.com>)
 id 1v188K-0003Pc-Gt
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 14:53:01 -0400
Received: from pps.filterd (m0484883.ppops.net [127.0.0.1])
 by mx0b-00300601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58NB5qvI029488;
 Tue, 23 Sep 2025 18:52:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=PPS11142024;
 bh=Px6YGZ48sPXzDjWpljCb4XloWMrMosfQuA3cRmjexsQ=; b=wASnRVdtOrYm
 f5t4pw0xPY10Gx+gp2fbiYUb8o7CpIEz3NBXW7MiKs9Yaib8ip6ev6iZGvoRp7Ay
 XBhFleObEOa3yl6jTYUfGqubRz3MEh1PrvjyVkC9kPfoiO0JFNrWlwgZhR+26OXX
 AtGOkDsQ2aGe7Ew7UG/fz1CGOz0sTtZnsZE7JT6iTTPui8Eqeq7RZE/6lRjFaXzM
 9eskRgjV+D/C6uaTkKS12Acu4cRQeUJ16Fh+ej4yDuru+k65ErkDn5Fofngyeyoc
 VggDrNDGy6+y4NUtLoafN6JCH56sUQRK2T3bZfXP2nd1DXmsMRNVShb9hPXuOQqI
 eHaDSyqSSg==
Received: from us-aus-excas-p2.ni.corp.natinst.com ([130.164.94.74])
 by mx0b-00300601.pphosted.com (PPS) with ESMTPS id 49btch3ka4-16
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Sep 2025 18:52:57 +0000 (GMT)
Received: from us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) by
 us-aus-excas-p2.ni.corp.natinst.com (130.164.68.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 23 Sep 2025 13:52:52 -0500
Received: from ershephe-ubuntu.ni.corp.natinst.com (172.18.68.32) by
 us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Tue, 23 Sep 2025 13:52:52
 -0500
From: Erick Shepherd <erick.shepherd@ni.com>
To: <berrange@redhat.com>
CC: <qemu-devel@nongnu.org>
Subject: Re: [PATCH] .gitmodules: Update URLs for the u-boot submodules
Date: Tue, 23 Sep 2025 13:52:51 -0500
Message-ID: <20250923185251.279242-1-erick.shepherd@ni.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <aNJD-OXimJj9KZkS@redhat.com>
References: <aNJD-OXimJj9KZkS@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Proofpoint-GUID: 5gAK7a-KbSkRIm-TTdii2tj9kkXSjlW0
X-Proofpoint-ORIG-GUID: 5gAK7a-KbSkRIm-TTdii2tj9kkXSjlW0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEwMiBTYWx0ZWRfX0mgxpZaZkHqC
 012CubhncsvpQRGsFMT17MHilph1hvlB0/VZVVnpbqUmcr0n8FBe4MPc6nbX7IEkqdCTEsesRIn
 Kvf6nA5nWYYyVfg8PSKbn/bvqATXTkJn/z0Jhu8mTxr/nA0PP3Ih78WYOayoXUtYPHKp2h9I1lE
 Revc9yf+sgNW++zppMOp4wCCyKNo0TyaX5u5tcUdfWontBLcQz6pxkK46zBdCPj2s8GCX4wg2JW
 wAJ+XHTvT6pn4Hxbu5YGJJ3sG4vdt0cJxM07wE4VTvp6UhaTjPImcrI0p6cT/Ke5HcjKXXnGUqM
 I4ZcueFHnEntzcWsBsPS7BGOvWBc5ym83uDlKrmiq0WxixRDhrDLyqV7gIbjnWvSiZKd9214jvc
 4QvpJT27
X-Authority-Analysis: v=2.4 cv=Q/bS452a c=1 sm=1 tr=0 ts=68d2ec89 cx=c_pps
 a=VUOoxcgKHUMpfFMIT0tLvw==:117 a=VUOoxcgKHUMpfFMIT0tLvw==:17
 a=yJojWOMRYYMA:10 a=Rk38NhaUC7qMvX-nwn8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_04,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0
 phishscore=0 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 clxscore=1011 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230102
Received-SPF: pass client-ip=148.163.142.35;
 envelope-from=prvs=8361951d9f=erick.shepherd@ni.com;
 helo=mx0b-00300601.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 23 Sep 2025 15:52:52 -0400
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

Ah, I must have missed that, are there any plans to cherrypick the=0D
change to any of the other branches? I'm particularly interested in the=0D
xlnx_rel_v2025.1 branch since that is what is used by the meta-xilinx=0D
scarthgap branch.=0D
=0D
Regards,=0D
Erick Shepherd=0D

