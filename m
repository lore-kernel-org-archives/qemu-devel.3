Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD672606A319
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 02:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=j3eIbGIW;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BPO8BpMv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK4v5-0006Sa-Qu; Thu, 22 Oct 2026 22:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK4uo-0006R9-RA
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 22:21:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK4um-0000tm-Pz
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 22:21:54 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N1ErIJ2376059
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 02:21:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 R4OXKbz9uHTP2OC9tYZ5psP0k7mQsgSbq64oqAFTH7o=; b=j3eIbGIWBiLp3c/R
 XIMN+H5wQXGVq46hdU06cgAnEJHRGYZoDeT7pUVz7EgU2D2JXHKGIZ9evQNFx6QH
 euXIWw6ObukUZjfcIsHNTZPWNSvcxctTPM1ZENq6rJc7Ot8lKydE7XNPvXKgFGO4
 xIpY0qmhayp6fK0CuhyQHCnPdHY6L9xOVoPUGi3XVThhJWsEuNYOnLFTpWx5yg6B
 DeitHcebfcRn+rGSY1Ee4P5JZIEk7vJcMwlI0WogSUnBIRcseN0H27DkalGtQEzd
 UZ9wQesQWMa6M1qUpki0ClblHbn2Vd7K8d7oNqsRLqj/DYF55iSLyKIWBJJLVO4+
 CG5WSQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmr9ejg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 02:21:50 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-35c5aef2a74so1830110eec.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 19:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792722110; x=1793326910; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=R4OXKbz9uHTP2OC9tYZ5psP0k7mQsgSbq64oqAFTH7o=;
 b=BPO8BpMvfB19f/7MB+CTOLHOMSS4DuP7TpZoB+ykMiCRBNLQBsXYBdR3mFTFPYcV+l
 R+Ng1jvL975ckOy508ipNy/lzrmJ8FtnoWHCN0QnQNzi1LZPL0bz8/crIE4T7m95xzZz
 yEO1gm0GnZgt5LYA/HqJLXNCf5d7srpj2RFeGMtaIZM8a5u57zBQbzvat3pWvKTVKGo8
 TwiVCY/lZguFDQ/WYChTp+H0ObZQusUIpYI0zGkWXpXQFhPM6NnMJG09umQozrKwXDfS
 M6c6bXx64uiYvgripIYjHjOOYY+zoBcRV82iKlPWs1sd6benDGvJGW/q1at5Xt9cROcn
 MOhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792722110; x=1793326910;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=R4OXKbz9uHTP2OC9tYZ5psP0k7mQsgSbq64oqAFTH7o=;
 b=Po6/SurLD+WbqhXWqqJSDjueKP90FvHfNQbwyLTS6NPYb214jL38jwpisMet6bV+4g
 vCI8AVwTH5fVltdZaUe7gIcZ5nvxN3oZ7Ssy1Nf1I8IM5/JXHHYMPfioKnAbkUFahw3r
 fCyLCyZ3F5sE9uMJS46TXxMTltERDbIdXRJwMgAPMCyQSm/scbSu873cvEmMb0kc/R+W
 t8iukawg17aiAqPvW3sXUsfvlRCkz0y3/570Gd06Mf5pOFq00uZDXnzwPXbv2P43DiKZ
 w9rHDuAuWijT494rPnhqJ2BP521A3fLdgnxL5M5wIlBPBFoN581JpVXGL7XkNtVL1LF8
 bGew==
X-Gm-Message-State: AFq9FYJhskM6hzjm+HHZIExXOLvShiMJBH95+YhAk6ufy/Y6dMKaPpOm
 NcH8Fu/g+u5h4dU1kJ/3j+qQSLlSnmWbOe7glqmsGv7CKnCqtf7JF6NoQTEtE45P48ztCYYjaUn
 0AwbHeH4pelEtsWlunHWYMp6HXjK6jxdRcLQK0stF9ITP85ymS8zBpSELg5PzQ9ngcw==
X-Gm-Gg: AYBFou0dbZfom4EE0Xhf1kYF8cNEgK86e4ZBBnwEIvB+iYc8tK1EoE3Etw0K2bGH+0C
 2zXamU9BEuG8suALgLCDVzsI09Vpj15/AFD7uyM73N/18HFSGO4xFh9KZzb7keoFD/9PcP9tf6V
 kD1dHIQzl1nnvlEsjhSVcGAgC78ovfUeGEq8b5YD8LVVnLLOt06xIr6M/EPpn0s9oH5+lq507/x
 Zj2Z70ROTJ/Su+BofC96VdeMMiliW9ZVCJAV9OpunNnzdAS+qBr5wL0t3er3B5JjptNlUG8BKFb
 ofn+h4C9iAK7Z3TfEu+82drlYN5Hogupx093eDa4a86MTq5WnsBLBkk8CCGZ6xoT7UTPHIh7Rwi
 r70Uh2JEHhY9eBBtoXobjcpl9g/SS1grljrnZwu24NFrN8g+L
X-Received: by 2002:a05:7022:ea8e:b0:190:8f72:445e with SMTP id
 a92af1059eb24-1959eb781dcmr1653175c88.11.1792722110044; 
 Thu, 22 Oct 2026 19:21:50 -0700 (PDT)
X-Received: by 2002:a05:7022:ea8e:b0:190:8f72:445e with SMTP id
 a92af1059eb24-1959eb781dcmr1653152c88.11.1792722109470; 
 Thu, 22 Oct 2026 19:21:49 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-195eae0e918sm2093713c88.11.2026.10.22.19.21.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 19:21:48 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 41/43] target/hexagon: fix semihosting OPEN filename handling
Date: Thu, 22 Oct 2026 18:50:38 -0700
Message-Id: <20261023015040.2473105-42-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023015040.2473105-1-brian.cain@oss.qualcomm.com>
References: <20261023015040.2473105-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: ilFW_focOz4U9l75Unhp8Go86gxPn7g6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAwOSBTYWx0ZWRfXxAoW2g6jbiHj
 IyNiHi3/DerfUj1+RbyvOS9LXeKH/gme+jdzYrXlMUzmbblu9GKAogw9vrgUjv7ACKv3umI8fQq
 yWXdsnlYyVMslPrYb8psmZyTxIMbrDU=
X-Authority-Analysis: v=2.4 cv=VNZIDNPX c=1 sm=1 tr=0 ts=6adac4be cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=wfIhpZVs-6LWPqknoVUA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAwOSBTYWx0ZWRfX59y8LnNDblvd
 4Pjlv1i0B/Pyaustf6VsxRPC65Zvv4q3BcIu+jctM2V/OjUrcNpD6G0OS6PH8EJ0DqSPCZ8IxQU
 JHxPOqxMDG/t00jn5K3xC5QcGp+XXwidWyevkJGGysJdXeNlJahCPC83I5Qvh1LT1QWTPwYHQeD
 xo6AmRu1plD9P1Aw6heWLm+/lsi6frgE3fTymoIvnJT4GWLVCq7SlOXQe8TLJrjTnfGV9soD8I/
 qj6INA4GpQPmkL0rzCtYMZ5ccp6fDb68RbVdnPQD9n25plCniMOlYbWmWozL38le+lD/DV54Iat
 NJV5lH/9GDi6Fk4mLskdtunuaImtbxB+XisCeMY+fdse7vh45sG+SQXTNuqtXlWL6iGB/evTlEQ
 iSQ0Y05szR5QufY0UpWc5n65Npv/AT4fTJ/09l0WLQtMwN9iNAZf/gRjTA9PvWatTjyYVEimw0L
 XGI/XHNDrWxw+0UfTKQ==
X-Proofpoint-ORIG-GUID: ilFW_focOz4U9l75Unhp8Go86gxPn7g6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230009
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SEVYX1NZU19PUEVOIGNvcGllZCBndWVzdCBieXRlcyBpbnRvIGEgZml4ZWQtc2l6ZSBidWZmZXIg
dW50aWwgaXQgZm91bmQgYQpOVUwuIEEgbWlzc2luZyB0ZXJtaW5hdG9yIGNvdWxkIG92ZXJydW4g
dGhhdCBidWZmZXIuIFVzZSBsb2NrX3VzZXIoKSB3aXRoCnRoZSBBQkkgZmlsZW5hbWUgbGVuZ3Ro
IGFuZCB2YWxpZGF0ZSBpdHMgdGVybWluYXRpbmcgTlVMIGJlZm9yZSBvcGVuaW5nIGl0LgoKRml4
ZXM6IDc3MTFmZGJhODhiICgidGFyZ2V0L2hleGFnb246IGFkZCBtYWluIGFyY2gtc3BlY2lmaWMg
c2VtaWhvc3Rpbmcgb3BlcmF0aW9ucyIpCkxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2Fs
bC9DQUZFQWNBOU1PczZWZkhmMlVIWjh6NGNkdmFCKzdEWTZoSmIyZW1ZWjJhTFNlLXQ2aXdAbWFp
bC5nbWFpbC5jb20vClN1Z2dlc3RlZC1ieTogUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBs
aW5hcm8ub3JnPgpSZXZpZXdlZC1ieTogUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5h
cm8ub3JnPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29t
bS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vaGV4c3dpLmMgfCAzMCArKysrKysrKysrKysrLS0t
LS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAxNyBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9oZXhzd2kuYyBiL3RhcmdldC9o
ZXhhZ29uL2hleHN3aS5jCmluZGV4IDg0Yzc3NDA5MWI1Li4wYmUxYzEzMDFlNyAxMDA2NDQKLS0t
IGEvdGFyZ2V0L2hleGFnb24vaGV4c3dpLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vaGV4c3dpLmMK
QEAgLTQ3MywzNSArNDczLDI5IEBAIHN0YXRpYyB2b2lkIHNpbV9oYW5kbGVfdHJhcDAoQ1BVSGV4
YWdvblN0YXRlICplbnYpCiAKICAgICBjYXNlIEhFWF9TWVNfT1BFTjoKICAgICB7Ci0gICAgICAg
IGNoYXIgZmlsZW5hbWVbQlVGU0laXTsKKyAgICAgICAgY2hhciAqZmlsZW5hbWU7CiAgICAgICAg
IHRhcmdldF91bG9uZyBwaHlzaWNhbF9maWxlbmFtZV9hZGRyOwogICAgICAgICB1bnNpZ25lZCBp
bnQgZmlsZW1vZGU7Ci0gICAgICAgIHVpbnQzMl90IGxlbmd0aDsKKyAgICAgICAgdWludDMyX3Qg
ZmlsZW5hbWVfbGVuOworICAgICAgICBzaXplX3QgZmlsZW5hbWVfc2l6ZTsKICAgICAgICAgaW50
IHJlYWxfb3Blbm1vZGU7CiAgICAgICAgIGludCByZXQsIGVyciA9IDA7Ci0gICAgICAgIGludCBp
ID0gMDsKIAogICAgICAgICBpZiAoZ2V0X3VzZXJfdTMyKHBoeXNpY2FsX2ZpbGVuYW1lX2FkZHIs
IHN3aV9pbmZvKSB8fAogICAgICAgICAgICAgZ2V0X3VzZXJfdTMyKGZpbGVtb2RlLCBzd2lfaW5m
byArIDQpIHx8Ci0gICAgICAgICAgICBnZXRfdXNlcl91MzIobGVuZ3RoLCBzd2lfaW5mbyArIDgp
KSB7CisgICAgICAgICAgICBnZXRfdXNlcl91MzIoZmlsZW5hbWVfbGVuLCBzd2lfaW5mbyArIDgp
KSB7CiAgICAgICAgICAgICBnb3RvIGRvX2ZhdWx0OwogICAgICAgICB9CiAKLSAgICAgICAgaWYg
KGxlbmd0aCA+PSBCVUZTSVopIHsKLSAgICAgICAgICAgIHFlbXVfbG9nX21hc2soTE9HX0dVRVNU
X0VSUk9SLAotICAgICAgICAgICAgICAgICAgICAgICAgICAiJXM6IGZpbGVuYW1lIHRvbyBsYXJn
ZSAoJSIgUFJJdTMyICIpXG4iLAotICAgICAgICAgICAgICAgICAgICAgICAgICBfX2Z1bmNfXywg
bGVuZ3RoKTsKLSAgICAgICAgICAgIHNlbWlfY2IoY3MsIC0xLCBFTkFNRVRPT0xPTkcpOwotICAg
ICAgICAgICAgYnJlYWs7CisgICAgICAgIC8qIFRoZSBBQkkgbGVuZ3RoIGV4Y2x1ZGVzIHRoZSBm
aWxlbmFtZSdzIHRlcm1pbmF0aW5nIE5VTC4gKi8KKyAgICAgICAgZmlsZW5hbWVfc2l6ZSA9IChz
aXplX3QpZmlsZW5hbWVfbGVuICsgMTsKKyAgICAgICAgZmlsZW5hbWUgPSBsb2NrX3VzZXIoVkVS
SUZZX1JFQUQsIHBoeXNpY2FsX2ZpbGVuYW1lX2FkZHIsCisgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGZpbGVuYW1lX3NpemUsIHRydWUpOworICAgICAgICBpZiAoIWZpbGVuYW1lIHx8IGZp
bGVuYW1lW2ZpbGVuYW1lX2xlbl0gIT0gJ1wwJykgeworICAgICAgICAgICAgdW5sb2NrX3VzZXIo
ZmlsZW5hbWUsIHBoeXNpY2FsX2ZpbGVuYW1lX2FkZHIsIDApOworICAgICAgICAgICAgZ290byBk
b19mYXVsdDsKICAgICAgICAgfQogCi0gICAgICAgIGRvIHsKLSAgICAgICAgICAgIGlmIChnZXRf
dXNlcl91OChmaWxlbmFtZVtpXSwgcGh5c2ljYWxfZmlsZW5hbWVfYWRkciArIGkpKSB7Ci0gICAg
ICAgICAgICAgICAgZ290byBkb19mYXVsdDsKLSAgICAgICAgICAgIH0KLSAgICAgICAgICAgIGkr
KzsKLSAgICAgICAgfSB3aGlsZSAoZmlsZW5hbWVbaSAtIDFdKTsKLQogICAgICAgICAvKiBjb252
ZXJ0IEFSTSBBTkdFTCBmaWxlbW9kZSBpbnRvIGhvc3QgZmlsZW1vZGUgKi8KICAgICAgICAgaWYg
KGZpbGVtb2RlIDwgQVJSQVlfU0laRShhbmdlbF90b19ob3N0X2ZpbGVtb2RlX3RhYmxlKSkgewog
ICAgICAgICAgICAgcmVhbF9vcGVubW9kZSA9IGFuZ2VsX3RvX2hvc3RfZmlsZW1vZGVfdGFibGVb
ZmlsZW1vZGVdOwpAQCAtNTA5LDYgKzUwMyw3IEBAIHN0YXRpYyB2b2lkIHNpbV9oYW5kbGVfdHJh
cDAoQ1BVSGV4YWdvblN0YXRlICplbnYpCiAgICAgICAgICAgICBxZW11X2xvZ19tYXNrKExPR19H
VUVTVF9FUlJPUiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgIiVzOiBpbnZhbGlkIE9QRU4g
bW9kZTogJXVcbiIsCiAgICAgICAgICAgICAgICAgICAgICAgICAgIF9fZnVuY19fLCBmaWxlbW9k
ZSk7CisgICAgICAgICAgICB1bmxvY2tfdXNlcihmaWxlbmFtZSwgcGh5c2ljYWxfZmlsZW5hbWVf
YWRkciwgMCk7CiAgICAgICAgICAgICBzZW1pX2NiKGNzLCAtMSwgRUlOVkFMKTsKICAgICAgICAg
ICAgIGJyZWFrOwogICAgICAgICB9CkBAIC01MjgsNiArNTIzLDcgQEAgc3RhdGljIHZvaWQgc2lt
X2hhbmRsZV90cmFwMChDUFVIZXhhZ29uU3RhdGUgKmVudikKICAgICAgICAgICAgICAgICByZXQg
PSBndWVzdGZkOwogICAgICAgICAgICAgfQogICAgICAgICB9CisgICAgICAgIHVubG9ja191c2Vy
KGZpbGVuYW1lLCBwaHlzaWNhbF9maWxlbmFtZV9hZGRyLCAwKTsKICAgICAgICAgc2VtaV9jYihj
cywgcmV0LCBlcnIpOwogICAgIH0KICAgICBicmVhazsKLS0gCjIuMzQuMQoK

