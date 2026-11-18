Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2098E606A32A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 17:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WYgbMMQo;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XlpYPSsg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTjS4-0007Jn-36; Wed, 18 Nov 2026 12:28:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xTjRy-0007JJ-Ed
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 12:28:02 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xTjRw-0001ij-Gw
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 12:28:02 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AIHGBU92745584
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 17:27:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cL4baHCPISmKeBA27CpokkbR1UFXPkgIIdMb65XeNT0=; b=WYgbMMQobJXDnOB1
 jzG7rBihfF4AFxPFdBevbUY2ojYxJd7iMkLtL4vHQF11Va1mXC60ajPJnkH3fT9X
 m7ozWq3NNwx1I1Ug9ibMzRJC5ui/tQRNC+IzpIS41IE1iA6hs0AswQvzgxZ6WYvK
 AnNP+0exOk26DOdwmdtKwW+41p4/MHy8atN2IILn9naPtinxulIC2mpHoqi3BeRZ
 eB6xmaFccYPxoGE/wku5KewPjV/C7KOnDfi9kDRvfPm3VqBfQFXecxluUvvKCKsv
 qkSvluq2lC5UM+RRrOMZ19BRnIzIp+LdFpUr6FZirPk6hSo4Gty8QA2NAo70KYbw
 Moxq7w==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1fpng84q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 17:27:53 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso1615695eec.1
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 09:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795022872; x=1795627672; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cL4baHCPISmKeBA27CpokkbR1UFXPkgIIdMb65XeNT0=;
 b=XlpYPSsgLaJCQDbi5clT+B/G9aYITKUKTNOKlqTz/b18E191KUxd4tPzQvsE7JsN82
 G4urecvKlvzENY7DLO10u+QrXqwwW0l4qE7eNPeEjbsJ/kQ7IK2K1dRBLN3kw+l/lMkf
 Fw+0kVToqLlR6Z3b8LgR1QrgFuC5b+cYrmW0Wc4oEd3jWyHmfYN1DNojZnDoMXVryNVT
 IEM9mTn94t4KeC4bzUs6p8iYdtDiT+yv/outsrVi65FgkXMyMN6eqg7OZbdrealiQ5g9
 kUoeAac6yKD/iYztnWRe0EHZvasX6pZKqehCM8Il3rOxYVw+1WymjWLOlakV5v9VSKxc
 388Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795022872; x=1795627672;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cL4baHCPISmKeBA27CpokkbR1UFXPkgIIdMb65XeNT0=;
 b=1pIODkBU+pMEzm+t9RXva71k3LxpdgdTGPavK5DTbOnxXzM/TB2UmzPvPR4AJ610In
 F8by8j4ucJDwJtXc6/LkRfM2yNpGkwxiKmvRdZlg9pHKS64n5B5b0htzekX3d8ZQrSSI
 yk8y+gPdv+jKKNMkuTBJa6+jWUli1RvvVxiH0cgwCpOxvrt82Ck95RfGN+oDPRlleizb
 ZDvReTYmPDpLu56vio1d1sr0sXD3/Nn9WvaghjOUrQykoNPHnkqOm2ODEVZdnRIJYivx
 yXFrsITGWCm/B1GvcR/w0caAPfHeiRVccdLY9NXx7u/+YMkS40u9xmX20qD3OPLp03QS
 Uk3A==
X-Forwarded-Encrypted: i=1;
 AL+hErGif0+IRiXI8NHVtuE+670D/nwJ6c3c7gzp5yC2N3cWAbgRiksoqcYAJ3mSEdgxCR5Nzq5zJTJLnBEz@nongnu.org
X-Gm-Message-State: APuU4Z/NSnaIpq4Ms1iBPJ/ecpx0gCxaCKxAXlhgnHkDCvsYnFANyiWC
 lYjRfCI2ZT9EbS8MgRvTuqr4k6J85mmEgNqeZcsHwTSwnsfnfCcq/GfIkd7P4CrPNpA/44IYYlm
 vHt7V/hCs3mfumovBTbwIKnsuzsLEVCCzWhy5jbEGy6p7rMnSWDnWTIdByFGtunLl0Q==
X-Gm-Gg: AYBFou3vA/hxqNKSBQVeACzCEt0fC3dIcYZBx98uDT6hwGULaJdj2lmas3RwpZXJeXZ
 4aYO0drYcEvDALNWT4qWCZ/IVV3kCEBsBlBL0N/INcsqN9FtSKsqZIHD/TvDPfNBX73eUqykxAK
 OZelzKETepuRwwpIDZc+0YYfq686qD1rT2Hm514y9/kKJs8g9Ae0UqTbITBQbj5RGh0QGFQbDmt
 TfhQoQkW7AD5GghJc9pIiQ6ozPgkpXCuLXOG+/GEaQL0qJqvJcFP4qJcd9+vjjHOxhqCf6e2r05
 RyE30dWV2cbs/u8TFySuQlNx1LZyuxTROzZp20/fXmwuwqnn8u5jyLtTXJJyC64LD0TyVyuiXrw
 TUi44oyWMquDFSqH639BtsIDeLR9SzpKVyX4danNLD7iEi0GAes23XZiMdJfJzPkG+0TpKtfIYT
 SgHF44zK41L1fKD6J9frV7U0yEws6oJlIr3wLJdxk8pG0=
X-Received: by 2002:a05:7022:3f01:b0:14d:c53a:f6a0 with SMTP id
 a92af1059eb24-1b543ccbe34mr3202617c88.13.1795022872121; 
 Wed, 18 Nov 2026 09:27:52 -0800 (PST)
X-Received: by 2002:a05:7022:3f01:b0:14d:c53a:f6a0 with SMTP id
 a92af1059eb24-1b543ccbe34mr3202579c88.13.1795022871205; 
 Wed, 18 Nov 2026 09:27:51 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5447f4eafsm7504496c88.14.2026.11.18.09.27.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 09:27:50 -0800 (PST)
Message-ID: <4980225a-9e81-4e1a-b1ee-47255726d92c@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 09:27:49 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/hexagon: Fix disassembly of extended GP-relative
 accesses
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: anjo@rev.ng
References: <20261118155745.3620910-1-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261118155745.3620910-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: M0UtfKU8BtWmR7QkFdmNkS_SuSQYB5Ll
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA2OSBTYWx0ZWRfX1CupPVpaHS30
 zYnzcCqlUztfUYe/vbVueCeo+CfgLRUCrdj7v7xYeK5/m8xDSBBw6Lky0ADzY9hHF5AgGW4Io+y
 6fIv4xqC1miDWARD6KXMJLh8f7QGV3QgpbTMR+Vtwv2Vnr1rzs2Ej8fAJ0+DZSQW36N3EeMzexF
 kDGVR3E1xvXHm0GP1wzVRne2/cHmlfYPjVQmV9PIKAyhn5qy9Nk6qIf6TSnWr72YkvsefUkOKst
 P1gNttxdNAd7Q/ySMgwshDwgbJsrvjuRTg7II8hO+VcTcIWOzSlvyhpu05yCvufig5vAXYBkDz4
 KdxWqTtABhL8RdX0+IsFIiyeRPZwMT7ubGCLal0TH9d69tWvXW9rttMFXO1nbklMMnCfTJhkPgi
 r9u1pgnkuj9RQ1vR6euUMviUKdwU3l97QlIPvd+7zRI7iJgiNoYkMLXBh92GPWLwLxYEktRn46I
 vWdFTGJevbxmbdGv0Ag==
X-Proofpoint-ORIG-GUID: M0UtfKU8BtWmR7QkFdmNkS_SuSQYB5Ll
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA2OSBTYWx0ZWRfX3uBVTkqNNUSD
 Hj40qeePnSgKc0x26ED7DjX11EAmHb2rXwCN3ahaNyP24+cERVvllJvczezFMHa61CyQkq+6abg
 v0rjyjLpVcDvBU97uozOXg0aSWK80dI=
X-Authority-Analysis: v=2.4 cv=PJ6aavqC c=1 sm=1 tr=0 ts=6afde019 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=0WyBHzKQqEKNu2kSXMoA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180069
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/18/2026 7:57 AM, Brian Cain wrote:
> A GP-relative load or store with a constant extender is an absolute
> access: the semantics read GP as 0 when insn->extension_valid is set,
> and the extended immediate is the full address.  The printed form kept
> the "gp+" base, so for example
> 
>     R0 = memw(gp+##0x48c30)
> 
> was shown for an instruction that accesses 0x48c30 and does not use GP.
> 
> Only print the "gp+" base when there is no extender.
> 
> Link: https://lore.kernel.org/qemu-devel/20261118144441.27680-1-anjo@rev.ng/
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/gen_printinsn.py | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

