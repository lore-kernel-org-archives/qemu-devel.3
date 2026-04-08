Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF2410F9969
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:25:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYTA-00078k-5T; Wed, 08 Apr 2026 15:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAY4c-0006SR-Nm
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:56:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAKOl-0005Yf-46
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 00:20:17 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6381FKkX1796828
 for <qemu-devel@nongnu.org>; Wed, 8 Apr 2026 04:20:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=U9YtuCo6FuZI/CcKOOjvfv
 0l3ElZbJzzhbgDdvj+HqQ=; b=RVxWCm0Y34HZg6dDxXo+138VeFHPZeHLagvQ7x
 Gz7WDjvNHk7+718xTLXo8H26jPup5g1y7znUqLhGLTDI1V7HdnYgLfXGClnKb79O
 5baWX9qtNwtv6qBm7a8o+E2XY9JdrEUUZxkhT5eX4JwayN27jAgo7//RJJuQllLV
 RZAre4z3TiN3FcuKHBYfTA88vkovJ3hqpkSSe28GzONHPMSPw3blWP5QikVE9omb
 rFmSV5vF8QKpvgn2gTQVzN2Ze5P0CSmxGf/tfcGMJcXltLRVirlGaN0/CnBJSoIS
 EJomVSgAGd+lvAkQwEIdHUvw6Ab9bYfo/svSzpbPkKtLYCpA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dd51da8ur-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 04:20:10 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1279caef718so9082655c88.1
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 21:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775622009; x=1776226809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=U9YtuCo6FuZI/CcKOOjvfv0l3ElZbJzzhbgDdvj+HqQ=;
 b=V45bwrEsUxnZ7zr4bW1HGXbPoAfRJJQ/lMDp8yv5kfsOhrdnnccGVdUlOBqf9Jybbx
 U493/HdBkkXbc94mfcgSDwh/61+1drdHPeYbCwy8zJjlzYsOUve4Ek6/IknIgNQQV6ed
 zY5GMuGX5y9MDcaYgAvT+ZVl7LKmVNo9DS1157QJE60M7C5jHwsi//cKLaL4mXvFV/39
 tpWljrT4IioVClOKzcj5Yrd2c6NcOryr0fyQc3ydcUtuU1ig7CgW93tR7xosHPgkGF/Q
 yFQCW7aloogta2aVcvyzFW2o3pvo4is7lxiZzdIkPeNmQ9qcExdhqE+VNat/MKhbGL0D
 oF7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775622009; x=1776226809;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U9YtuCo6FuZI/CcKOOjvfv0l3ElZbJzzhbgDdvj+HqQ=;
 b=gkad6pGM1guxm0vyYeyVzRJC6eErRC4B1V9JRhn2izMI/NF1QWR/AHSboe4AUO8dJG
 3be3n68TDBooGThTsWTpTBhRmRCxWJt08Fl4v9CCg0xhXaY/toq6tAdrg2+DN2w4cuHr
 Ou4YKal0JNo53DO+3WvjcpUtFb/lV+9GfhtmcIrPYwBTqea3fQlF8X6deYtD8UGU3njH
 wms1LG0C4K1B1uFsBT+A/koAyMZnurORPzoeo++q28Hu0mgymwuG4scNVqhkkUzHHFUy
 N+HkxDlnaN9SGrm0hSD77wrbUP0UjUJ5Ls0SOJywELZuCVITnN96NH1BHC8xTm0WnHB9
 xoIA==
X-Gm-Message-State: AOJu0YwD6zhYnyO+wrs57yYnyiYhiYUfr+u/N4Vj3Vk8Vl4zD2ztf8ba
 iYLAlC+Bk8RKmO7CvbCFfvMLn9hzqmTeAciAr/lXn36BCgbPHnds28hJn+It2n6rIu48Qtm4oat
 0+bO4O8oirc26RS8NijWTBV4LiTzDHu5Cz7XTKCip2Q/hZL1lkqZnd2hY7K01M4FeTg==
X-Gm-Gg: AeBDieulVBa1unMmCwQKamJfdp/d4HjjYaGrFAkciBvdMDSqyGn747hFcdvKtQgpLtT
 00VEr7+A8nK+UV2v1+cNGYj03L0b8vf9fkTVUvaLykSZZ8DL5DehWPXSZdlmXK9qhNcl8hF89AL
 JlMiAqS3BWVrsn9d1CGGLMR6/IT24MreSNTKnOOI9Sfvrsr+Ix2n20fZDFpvBk7ndYLWaZ0NsgB
 qLo2V2uzLbZS+H6vZxCeVw2XxtoW/7i0BmyskIpu09N8H/Tt5GL9+Smfugzz3Sxajv+pj525ukF
 rHKd085Wkx4JRC1LXIPEQ3MVeacLEpWR5ruylQZDLrvrHsJjDLQPAk7HWJfGYYBF3zeQkK4/hug
 Ndf7S+QTVTT38ZKfyondDqBVZV1iBVVjZ8ObmmVktWgKKlLC1REGiKRpQ6RqIsrGs0IJo3A==
X-Received: by 2002:a05:7022:929:b0:127:380e:ff5a with SMTP id
 a92af1059eb24-12bfb73e31emr9753765c88.17.1775622009199; 
 Tue, 07 Apr 2026 21:20:09 -0700 (PDT)
X-Received: by 2002:a05:7022:929:b0:127:380e:ff5a with SMTP id
 a92af1059eb24-12bfb73e31emr9753744c88.17.1775622008539; 
 Tue, 07 Apr 2026 21:20:08 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c14a371b1sm6480362c88.13.2026.04.07.21.20.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 21:20:08 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Subject: [PATCH v4 00/28] Hexagon system emulation - Part 2/3
Date: Tue,  7 Apr 2026 21:19:25 -0700
Message-Id: <20260408041953.1899532-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: lhzzNcwYFnR4Z7nKoyGgvmT-ZERtuVWk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNSBTYWx0ZWRfX73QV1z985EXH
 4nG81tTxUGuElC0tCLzCKRJETITt6TIqnez3cAOEAsXu1ejOYDei+voCTe7GgocRfRZ4zVLIkGn
 xg+h23dpr/ss3pEagIVJouwtlTfIg9rs8S/XPGCXMLfUA/RpiKTXNX/92WOiOYHNcIqp2kAP1Jy
 YMOro2W4X0Rc7GHNLqPtzr5f1e8Xrezp01G4IJwFfsJ8kDc8IQXS8Cli50D5meHJB3Yv6W7sOPO
 8r/VB9tQNsjl4nfbjjJoPj63irn1wb1PvITAhjrrXYaa6jTZa4hlymg9dNsPNsywkzdsu9OQYzg
 ETUnacnzCSyibf9106R4cXP9Xq4EZ+eAEsZuWCmwoiKVialTn1h7fYwBCP2d6//oDWWNVj0/ymi
 Fmt/TAUXcPIhKoPEtN64hfzy/+nHPq267D7auWz1I+re1sFoFvwM27z/CjklUgxThmlj+CWRgB/
 oV7tY1HuMeCcv0GtY+A==
X-Authority-Analysis: v=2.4 cv=AcaB2XXG c=1 sm=1 tr=0 ts=69d5d77a cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Ft1SjsLI0j10gtFiCOkA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: lhzzNcwYFnR4Z7nKoyGgvmT-ZERtuVWk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 phishscore=0 impostorscore=0 spamscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080035
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

VGhpcyBpcyBQYXJ0IDIgb2YgdGhlIEhleGFnb24gc3lzdGVtIGVtdWxhdGlvbiBzZXJpZXMuICBJ
dCBhZGRzIHRoZQpydW50aW1lIGhlbHBlcnMsIENQVSBvcGVyYXRpb25zLCBhbmQgdHJhbnNsYXRp
b24gc3VwcG9ydCBuZWVkZWQgZm9yCmZ1bGwtc3lzdGVtIGVtdWxhdGlvbiBvZiB0aGUgSGV4YWdv
biBEU1AuCgpUaGlzIGluY2x1ZGVzOgogLSBTb2Z0d2FyZSBpbnRlcnJ1cHQgKFNXSSkgYW5kIGlu
dGVycnVwdCBoYW5kbGluZwogLSBUTEIgZmlsbCBhbmQgcGVybWlzc2lvbiBjaGVja2luZwogLSBT
eXN0ZW0gcmVnaXN0ZXIgcmVhZC93cml0ZSBzdXBwb3J0IGluIFRDRwogLSBJbXBsaWNpdCBzeXNy
ZWcgd3JpdGVzIGFuZCB0cmFuc2xhdGlvbi1ibG9jayB0ZXJtaW5hdGlvbgogLSBTdGFjayBvdmVy
ZmxvdyBleGNlcHRpb24gc3VwcG9ydAogLSBUaHJlYWQgc2NoZWR1bGluZyBoZWxwZXJzIChzZXRw
cmlvLCByZXNjaGVkLCByZXN1bWUpCiAtIGswIGxvY2svdW5sb2NrIGZvciBrZXJuZWwgbW9kZQog
LSBpZGVmLXBhcnNlciBzdXBwb3J0IGZvciBmRlJBTUVDSEVDSwogLSBUQ0cgb3ZlcnJpZGVzIGZv
ciBzeXN0ZW0gdHJhbnNmZXIgaW5zdHJ1Y3Rpb25zCgpCYXNlZCBvbiBQYXJ0IDEgdjYuCgpDaGFu
Z2VzIHNpbmNlIHYzOgogLSBSZWJhc2VkIG9udG8gUGFydCAxIHY2CiAtIEZpeGVkIGlkZWYtcGFy
c2VyIGZGUkFNRUNIRUNLIGltcGxlbWVudGF0aW9uIChUYXlsb3IpCiAtIFJlbW92ZWQgcGt0X2Vu
ZHNfdGIgZnJvbSBEaXNhc0NvbnRleHQsIGNhbGwgcGt0X2VuZHNfdGIoKSBkaXJlY3RseSAoVGF5
bG9yKQogLSBDaGFuZ2VkIHRfc3JlZ19uZXdfdmFsdWUgc2l6aW5nIGZyb20gTlVNX1NSRUdTIHRv
CiAgIEhFWF9TUkVHX0dMQl9TVEFSVCAoVGF5bG9yKQogLSBSZW1vdmVkIHVubmVjZXNzYXJ5IHRj
Z19nZW5fbW92X3RsIHNyZWcgcHJlLWNvcHkgaW4KICAgZ2VuX3N0YXJ0X3BhY2tldCgpOyBubyBz
cmVnIHdyaXRlcyBhcmUgcHJlZGljYXRlZCAoVGF5bG9yKQogLSBBZGRlZCBjb250aW51ZSBhZnRl
ciBTVElEL0lNQVNLL0lQRU5EQUQgd3JpdGViYWNrIGluCiAgIGdlbl9zcmVnX3dyaXRlcygpIHRv
IGF2b2lkIHJlZHVuZGFudCB3cml0ZWJhY2sgKFRheWxvcikKIC0gTW92ZWQgaGV4YWdvbl9ncmVn
X3JlYWQoKSBkZWNsYXJhdGlvbiB0byBjb3JyZWN0IGNvbW1pdCAoVGF5bG9yKQogLSBGaXhlZCBz
ZXRfZW5hYmxlX21hc2svY2xlYXJfZW5hYmxlX21hc2sgcmV0dXJuIHR5cGUgY29uc2lzdGVuY3kg
KFRheWxvcikKIC0gQWRkZWQgZWFybHkgcmV0dXJuIGZvciBnbG9iYWxyZWdzPT1mYWxzZSBpbiBz
ZXRfZW5hYmxlX21hc2sgYW5kCiAgIHNldF93YWl0X21vZGUgKFRheWxvcikKIC0gRml4ZWQgYmFy
ZSAleC8lZCBmb3JtYXQgc3BlY2lmaWVycyBhY3Jvc3MgbXVsdGlwbGUgZmlsZXMsIHVzaW5nCiAg
IFBSSXgzMi9QUkl1MzIvVEFSR0VUX0ZNVF9seCBhcyBhcHByb3ByaWF0ZSAoVGF5bG9yKQogLSBG
aXhlZCBtaWQtYmxvY2sgdmFyaWFibGUgZGVjbGFyYXRpb25zIChDODkgc3R5bGUpCiAtIFJlbW92
ZWQgaW52YWxpZCBQUk0gc2VjdGlvbiByZWZlcmVuY2VzIGZyb20gc2V0cHJpby9yZXNjaGVkCiAg
IGNvbW1pdCBtZXNzYWdlIChUYXlsb3IpCiAtIFJlbmFtZWQgIkFkZCBUTEIsIGswIHt1bix9bG9j
ayIgdG8gIkFkZCBrMCB7dW4sfWxvY2siIChUYXlsb3IpCiAtIE1vdmVkIGN5Y2xlIGNvdW50ZXIv
cGN5Y2xlL21vZGlmeV9zc3IgY29tbWl0cyB0byBQYXJ0IDEKIC0gQWxsIGN5Y2xlIGNvdW50ZXIg
Y29kZSBwcm9wZXJseSBndWFyZGVkIGJ5CiAgIGlmbmRlZiBDT05GSUdfVVNFUl9PTkxZIChUYXls
b3IpCgpQcmV2aW91cyB2ZXJzaW9uczoKIC0gdjM6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3Fl
bXUtZGV2ZWwvMjAyNjAzMTEwNDA3NTguMTA2ODczMS0xLWJyaWFuLmNhaW5Ab3NzLnF1YWxjb21t
LmNvbS8KIC0gdjI6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNTA5MDIw
MzQ4NDcuMTk0ODAxMC0xLWJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbS8KIC0gdjE6IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNTAzMDEwNTI4NDUuMTAxMjA2OS0xLWJy
aWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbS8KCkJyaWFuIENhaW4gKDI2KToKICB0YXJnZXQvaGV4
YWdvbjogSW1wbGVtZW50IHtjLH1zd2kgaGVscGVycwogIHRhcmdldC9oZXhhZ29uOiBJbXBsZW1l
bnQgaWFzc2lnbntyLHd9IGhlbHBlcnMKICB0YXJnZXQvaGV4YWdvbjogSW1wbGVtZW50IHN0YXJ0
L3N0b3AgaGVscGVycywgc29mdCByZXNldAogIHRhcmdldC9oZXhhZ29uOiBJbXBsZW1lbnQge2cs
c31ldGltYXNrIGhlbHBlcnMKICB0YXJnZXQvaGV4YWdvbjogSW1wbGVtZW50IHdhaXQgaGVscGVy
CiAgdGFyZ2V0L2hleGFnb246IEltcGxlbWVudCBnZXRfZXhlX21vZGUoKQogIHRhcmdldC9oZXhh
Z29uOiBJbXBsZW1lbnQgaGV4X3RsYl9lbnRyeV9nZXRfcGVybSgpCiAgdGFyZ2V0L2hleGFnb246
IEltcGxlbWVudCBzb2Z0d2FyZSBpbnRlcnJ1cHQKICB0YXJnZXQvaGV4YWdvbjogSW1wbGVtZW50
IHN0YWNrIG92ZXJmbG93IGV4Y2VwdGlvbgogIHRhcmdldC9oZXhhZ29uOiBJbXBsZW1lbnQgZXhl
Y19pbnRlcnJ1cHQsIHNldF9pcnEKICB0YXJnZXQvaGV4YWdvbjogSW1wbGVtZW50IGhleGFnb25f
dGxiX2ZpbGwoKQogIHRhcmdldC9oZXhhZ29uOiBJbXBsZW1lbnQgc2lhZCBpbnN0CiAgdGFyZ2V0
L2hleGFnb246IEltcGxlbWVudCBoZXhhZ29uX3Jlc3VtZV90aHJlYWRzKCkKICB0YXJnZXQvaGV4
YWdvbjogSW1wbGVtZW50IHNldHByaW8sIHJlc2NoZWQKICB0YXJnZXQvaGV4YWdvbjogQWRkIHN5
c2VtdV9vcHMsIGNwdV9nZXRfcGh5c19wYWdlX2RlYnVnKCkKICB0YXJnZXQvaGV4YWdvbjogZXh0
ZW5kIGhleGFnb25fY3B1X21tdV9pbmRleCgpIGZvciBzeXNlbXUKICB0YXJnZXQvaGV4YWdvbjog
RGVjb2RlIHRyYXAxLCBydGUgYXMgQ09GCiAgdGFyZ2V0L2hleGFnb246IEltcGxlbWVudCBtb2Rp
Znlfc3NyLCByZXNjaGVkLCBwZW5kaW5nX2ludGVycnVwdAogIHRhcmdldC9oZXhhZ29uOiBBZGQg
cGt0X2VuZHNfdGIgdG8gdHJhbnNsYXRpb24KICB0YXJnZXQvaGV4YWdvbjogQWRkIG5leHRfUEMs
IHtzLGd9cmVnIHdyaXRlcwogIHRhcmdldC9oZXhhZ29uOiBBZGQgaW1wbGljaXQgc3lzcmVnIHdy
aXRlcwogIHRhcmdldC9oZXhhZ29uOiBEZWZpbmUgc3lzdGVtLCBndWVzdCByZWcgbmFtZXMKICB0
YXJnZXQvaGV4YWdvbjogQWRkIGswIHt1bix9bG9jawogIHRhcmdldC9oZXhhZ29uOiBBZGQgUEMg
dG8gcmFpc2VfZXhjZXB0aW9uLCB1c2UgZlRSQVAoKSBoZWxwZXIKICB0YXJnZXQvaGV4YWdvbjog
QWRkIFRDRyBvdmVycmlkZXMgZm9yIHRyYW5zZmVyIGluc3RzCiAgdGFyZ2V0L2hleGFnb246IEFk
ZCBzdXBwb3J0IGZvciBsb2Fkd19waHlzCgpNYXRoZXVzIFRhdmFyZXMgQmVybmFyZGlubyAoMik6
CiAgdGFyZ2V0L2hleGFnb246IGFkZCBzaW1wbGUgY3B1X2V4ZWNfcmVzZXQgYW5kIHBvaW50ZXJf
d3JhcAogIHRhcmdldC9oZXhhZ29uOiBBZGQgZ3Vlc3QgcmVnIHJlYWRpbmcgZnVuY3Rpb25hbGl0
eQoKIHRhcmdldC9oZXhhZ29uL2NwdS5oICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTEgKwog
dGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5oICAgICAgICAgICAgICAgICB8ICAgOCArCiB0YXJn
ZXQvaGV4YWdvbi9nZW5fdGNnLmggICAgICAgICAgICAgICAgICAgIHwgICA3IC0KIHRhcmdldC9o
ZXhhZ29uL2dlbl90Y2dfc3lzLmggICAgICAgICAgICAgICAgfCAgMjUgKysKIHRhcmdldC9oZXhh
Z29uL2hlbHBlci5oICAgICAgICAgICAgICAgICAgICAgfCAgIDYgKy0KIHRhcmdldC9oZXhhZ29u
L2hleHN3aS5oICAgICAgICAgICAgICAgICAgICAgfCAgMTcgKwogdGFyZ2V0L2hleGFnb24vaWRl
Zi1wYXJzZXIvcGFyc2VyLWhlbHBlcnMuaCB8ICAgMiArCiB0YXJnZXQvaGV4YWdvbi9pbnRlcm5h
bC5oICAgICAgICAgICAgICAgICAgIHwgICA0ICsKIHRhcmdldC9oZXhhZ29uL21hY3Jvcy5oICAg
ICAgICAgICAgICAgICAgICAgfCAgIDMgLQogdGFyZ2V0L2hleGFnb24vc3lzX21hY3Jvcy5oICAg
ICAgICAgICAgICAgICB8ICAgNyArCiB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaCAgICAgICAg
ICAgICAgICAgIHwgICA1ICstCiB0YXJnZXQvaGV4YWdvbi9yZWdfZmllbGRzX2RlZi5oLmluYyAg
ICAgICAgIHwgIDExICsKIGxpbnV4LXVzZXIvaGV4YWdvbi9jcHVfbG9vcC5jICAgICAgICAgICAg
ICAgfCAgIDcgKwogdGFyZ2V0L2hleGFnb24vY3B1LmMgICAgICAgICAgICAgICAgICAgICAgICB8
IDM2MCArKysrKysrKysrKysrKy0KIHRhcmdldC9oZXhhZ29uL2RlY29kZS5jICAgICAgICAgICAg
ICAgICAgICAgfCAgMTQgKwogdGFyZ2V0L2hleGFnb24vZ2VucHRyLmMgICAgICAgICAgICAgICAg
ICAgICB8ICAxOCArLQogdGFyZ2V0L2hleGFnb24vaGV4c3dpLmMgICAgICAgICAgICAgICAgICAg
ICB8IDI2NyArKysrKysrKysrKwogdGFyZ2V0L2hleGFnb24vaWRlZi1wYXJzZXIvcGFyc2VyLWhl
bHBlcnMuYyB8ICAgOSArCiB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyAgICAgICAgICAgICAg
ICAgIHwgNDYyICsrKysrKysrKysrKysrKysrKystCiB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUu
YyAgICAgICAgICAgICAgICAgIHwgMjI1ICsrKysrKysrKy0KIHRhcmdldC9oZXhhZ29uL2hleF9j
b21tb24ucHkgICAgICAgICAgICAgICAgfCAgIDMgKwogdGFyZ2V0L2hleGFnb24vaWRlZi1wYXJz
ZXIvaWRlZi1wYXJzZXIueSAgICB8ICAgMyArCiB0YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9lbmNv
ZGVfcHAuZGVmICAgICAgIHwgICAxICsKIHRhcmdldC9oZXhhZ29uL2ltcG9ydGVkL2xkc3QuaWRl
ZiAgICAgICAgICAgfCAgIDMgKwogMjQgZmlsZXMgY2hhbmdlZCwgMTQyNSBpbnNlcnRpb25zKCsp
LCA1MyBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0YXJnZXQvaGV4YWdvbi9oZXhz
d2kuaAogY3JlYXRlIG1vZGUgMTAwNjQ0IHRhcmdldC9oZXhhZ29uL2hleHN3aS5jCgotLSAKMi4z
NC4xCgo=

