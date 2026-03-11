Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E49F7FD88F5
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 04:13:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0AsK-0000sN-77; Wed, 11 Mar 2026 00:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0As7-0000oD-Tm
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:08:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0As5-0008W8-S3
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:08:35 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62B1gtCH508501
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nVDQBNnnspnNukvGykCY/YA++OQ5z5cGx4OKxmhqeiU=; b=nO3JLWLYoVTX5AjV
 5NQaAiyMxILwgZOWStHXvsw8GiHDgg/VL3XxIujTezMgygSwUaJg788c3igdnGPc
 k+iKRuSrXTKKDDukiyrjgfTlWyXcCNlyho7FvZ6y3sa2iMTEeqRM/87BwafSXlNf
 ubXipRNccclmvSXPUUME8jElkwp732RhbuG5orSCR8UDuKLZpIT2K8deBZbZ38kB
 6y++SsUhFULHWwTN9MxT9Qf1iGPgQgsjmHz9uCzEogXhOoAlA7d3o0JX4pqPKXdI
 psDkJH80hLR1hU713CpBMeM09rxXa2u83CRwVZQVut6P/pfCyeEF3GHnUQwOJb7s
 eo06RQ==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctppaj4ya-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:30 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-40ee506cf49so58615509fac.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 21:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773202110; x=1773806910; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nVDQBNnnspnNukvGykCY/YA++OQ5z5cGx4OKxmhqeiU=;
 b=RQ5jtRSlB7aE54ozgB3OUOMXoR3m45Xgfan8J6Dkt/itWlXjMLVrDDPw/sFxSW7/gN
 QLVmB5gxu8yTw60cb64D8X0g3U1/4QhDfWnCkOnB+2DOb6nDeu7NxX/VJjDAufbDf0fi
 2XviX2kGVXQQOLnbsbqw04vaRKnLCKB+NeVOlqfWkeEZ/w9whzxJ6oQ0FLgTWxhJb60v
 QG013L2o/AmCuo4P+z1oMOq9dIb4cYXG8/oJAutdW0/hcYR7DBNS/2pBkKxjSq3z5xIm
 dv76oyM88jH8CI57oMkkRnpX7wgF4ipF+SomyEiEFnUZGu6RidGDmW0Y4RjpV7mguVQd
 RqTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773202110; x=1773806910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nVDQBNnnspnNukvGykCY/YA++OQ5z5cGx4OKxmhqeiU=;
 b=YmpX3esDnOA7XxBvYevcaUZj1QM3z3TfzmPm0T25jqHAxQdlcXkA03lHcMMxxP6NtV
 vTYxtWUvPgzBHtdBp540sli+lh06qk4kgrDNJQBSMLycKQhTq3FBuil6UFctIenleP+5
 scuttkZrlUtxbvOuLSOOuPpxggTuy/djxDljmlj9/PfHvPT2GDub+f8s6YlWvM+nlC3o
 /RvNr8QVQEFVZTjMvyHL324hxgOGkpLLYgSPL265O61E4GSwiII66m1IhBpkT7aZENFQ
 quBPnUzKXoIICRuGxT4+KinJnjJVJxuo2xbYv0bJmWNFV1j/kNgmYpy0MIYA9UD3O4rV
 aBDw==
X-Gm-Message-State: AOJu0Yy4e6vBGXs+QX7VHldP1isSEceHXLV6/U31KiuxJPgMDF5Dl514
 GT28W01FiZyhqekUC/SpWzsasYB15KOTBkL46EE406qeO7WtYdNbtIDdBHam/uimfS46o8tvCSF
 HJMpsVwfsqQLdoAaqtIWoBBFlstp+MgGJpDwx5R2Y/qI7EfIkMWOJnCZi8AkHi/vZ/Q==
X-Gm-Gg: ATEYQzwieFz5UY42E+kV8l9W9nGy3BsK38op8kYinzOGmDhl3Wy+wxTTHvleu8zn0V1
 g/hOFgXL7h5+Sl7yhmAwNJG1e4d5Vn2xYsDvoa+J6UL3rPi3hKTbeY1rBg9J2F6WcnGU8La0DFw
 x4mW5zBSkOLUC+b6R0xJGZKKH/SD+YOH6sJf50v9qVutT5vwEvmZFKD2Vx/b/1WW3SM+jfG4SMe
 Z1tf/BC5rz/9exlRdBuJTNgXqwGk1+X9CtwlU20gedgX3vc4hq/htiGbFUTh0lHgfkvw2XmeX5Z
 OKtuniFH6pf8KKc6RKrDAsDtmzUD1MsRPtbUL+6xoSBEZWLgEuxP1MPcPoSG/1X1Ex1RTEBCF9t
 s/HaF1ub3aubAzMx5u+N8m5FOuzjhFCPIThv14pL/esAxWH+ObdGnPB7uYgoE1nWhORzmbA==
X-Received: by 2002:a05:6870:be8b:b0:2e9:93c6:6e4a with SMTP id
 586e51a60fabf-4177cabc152mr876465fac.38.1773202110182; 
 Tue, 10 Mar 2026 21:08:30 -0700 (PDT)
X-Received: by 2002:a05:6870:be8b:b0:2e9:93c6:6e4a with SMTP id
 586e51a60fabf-4177cabc152mr876445fac.38.1773202109742; 
 Tue, 10 Mar 2026 21:08:29 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e5ea30asm998656fac.10.2026.03.10.21.08.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 21:08:29 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v3 17/32] target/hexagon: Implement hexagon_resume_threads()
Date: Tue, 10 Mar 2026 21:07:43 -0700
Message-Id: <20260311040758.1068731-18-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
References: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: r4VdKHqSxjflv8p4IjhA2OTxEny1tS0A
X-Authority-Analysis: v=2.4 cv=D7BK6/Rj c=1 sm=1 tr=0 ts=69b0eabe cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=lFhGULv_JCWPxgfyECsA:9
 a=QEXdDO2ut3YA:10 a=eBU8X_Hb5SQ8N-bgNfv4:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAzMiBTYWx0ZWRfX/FxOSxxYxGaC
 DLY3NjYZE0NMZUEdltfvD9sAZCUdKOZdXjjZG9tiWBNDFqcjneestCV7qlolS3UDFx78Jt2E71V
 gmTp7imaoUqNfPj3vDYFzXEKPOP3G+M0I6yH0+KcVAH4z8T+3msxLPSLURJYdzHTBcGGk+LWe1/
 HsC4iZrVKDTBJKi+ilJIQqFUP/NGFdK2TgiUQBB3Xn0uAATu1IKZ+v1Lm+HFOO8AaziPCPYMLBZ
 PB6KDwkFsTvExOlkWV4GX3b7P23CsQ9fLeMJAeneXLwiO3ii/L+vExXHbpGHcKAXClYQYJIQS97
 54yLFvNFCgPjUx3sTQCAfRkwz6ajK5c5B4Hnh5d9JJf+wrwBYCSNxOFDrv6PBAccTQXO+onTEaP
 k2WAlw5GQmJZaV3Zc+YxOlkhVOinIZHeBBeSdum4PNgqw7F7LwzDTc9HNwn9YDQNeoVwvLylCX2
 bzluTLXxJ3nz9MAOpSw==
X-Proofpoint-ORIG-GUID: r4VdKHqSxjflv8p4IjhA2OTxEny1tS0A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 impostorscore=0 spamscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603110032
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Nw
dS5oICAgICAgICB8ICAxICsKIHRhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuaCB8ICAxICsKIHRh
cmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuYyB8IDM2ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKwogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgIHwgIDMgKystCiA0IGZpbGVz
IGNoYW5nZWQsIDQwIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS90
YXJnZXQvaGV4YWdvbi9jcHUuaCBiL3RhcmdldC9oZXhhZ29uL2NwdS5oCmluZGV4IDM0NDY5MTBm
ZWI2Li42MTY4ZmVhM2I1ZiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1LmgKKysrIGIv
dGFyZ2V0L2hleGFnb24vY3B1LmgKQEAgLTUwLDYgKzUwLDcgQEAKICNkZWZpbmUgUFJFRF9XUklU
RVNfTUFYIDUgICAgICAgICAgICAgICAgICAgLyogNCBpbnNucyArIGVuZGxvb3AgKi8KICNkZWZp
bmUgVlNUT1JFU19NQVggMgogI2RlZmluZSBNQVhfVExCX0VOVFJJRVMgMTAyNAorI2RlZmluZSBU
SFJFQURTX01BWCA4CiAKICNkZWZpbmUgQ1BVX1JFU09MVklOR19UWVBFIFRZUEVfSEVYQUdPTl9D
UFUKICNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24v
Y3B1X2hlbHBlci5oIGIvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5oCmluZGV4IDcyZjgzZDYy
YTU0Li5kYzk5YjRjMjk0YiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5o
CisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuaApAQCAtMjAsNSArMjAsNiBAQCB2b2lk
IGNsZWFyX3dhaXRfbW9kZShDUFVIZXhhZ29uU3RhdGUgKmVudik7CiB2b2lkIGhleGFnb25fc3Ny
X3NldF9jYXVzZShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgY2F1c2UpOwogdm9pZCBo
ZXhhZ29uX3N0YXJ0X3RocmVhZHMoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IG1hc2sp
Owogdm9pZCBoZXhhZ29uX3N0b3BfdGhyZWFkKENQVUhleGFnb25TdGF0ZSAqZW52KTsKK3ZvaWQg
aGV4YWdvbl9yZXN1bWVfdGhyZWFkcyhDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgbWFz
ayk7CiAKICNlbmRpZgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jIGIv
dGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jCmluZGV4IDcyOWZmYTQ3ZWVkLi5kY2IwNzI4MzQ5
NCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jCisrKyBiL3RhcmdldC9o
ZXhhZ29uL2NwdV9oZWxwZXIuYwpAQCAtODcsNiArODcsNDIgQEAgdm9pZCBoZXhhZ29uX3NldF9z
eXNfcGN5Y2xlX2NvdW50KENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50NjRfdCBjeWNsZXMpCiAg
ICAgfQogfQogCitzdGF0aWMgdm9pZCBoZXhhZ29uX3Jlc3VtZV90aHJlYWQoQ1BVSGV4YWdvblN0
YXRlICplbnYpCit7CisgICAgQ1BVU3RhdGUgKmNzID0gZW52X2NwdShlbnYpOworICAgIGNsZWFy
X3dhaXRfbW9kZShlbnYpOworICAgIC8qCisgICAgICogVGhlIHdhaXQgaW5zdHJ1Y3Rpb24ga2Vl
cHMgdGhlIFBDIHBvaW50aW5nIHRvIGl0c2VsZgorICAgICAqIHNvIHRoYXQgaXQgaGFzIGFuIG9w
cG9ydHVuaXR5IHRvIGNoZWNrIGZvciBpbnRlcnJ1cHRzLgorICAgICAqCisgICAgICogV2hlbiB3
ZSBjb21lIG91dCBvZiB3YWl0IG1vZGUsIGFkanVzdCB0aGUgUEMgdG8gdGhlCisgICAgICogbmV4
dCBleGVjdXRhYmxlIGluc3RydWN0aW9uLgorICAgICAqLworICAgIGVudi0+Z3ByW0hFWF9SRUdf
UENdID0gZW52LT53YWl0X25leHRfcGM7CisgICAgY3MgPSBlbnZfY3B1KGVudik7CisgICAgQVNT
RVJUX0RJUkVDVF9UT19HVUVTVF9VTlNFVChlbnYsIGNzLT5leGNlcHRpb25faW5kZXgpOworICAg
IGNzLT5oYWx0ZWQgPSBmYWxzZTsKKyAgICBjcy0+ZXhjZXB0aW9uX2luZGV4ID0gSEVYX0VWRU5U
X05PTkU7CisgICAgcWVtdV9jcHVfa2ljayhjcyk7Cit9CisKK3ZvaWQgaGV4YWdvbl9yZXN1bWVf
dGhyZWFkcyhDUFVIZXhhZ29uU3RhdGUgKmN1cnJlbnRfZW52LCB1aW50MzJfdCBtYXNrKQorewor
ICAgIENQVVN0YXRlICpjczsKKyAgICBDUFVIZXhhZ29uU3RhdGUgKmVudjsKKworICAgIGdfYXNz
ZXJ0KGJxbF9sb2NrZWQoKSk7CisgICAgQ1BVX0ZPUkVBQ0goY3MpIHsKKyAgICAgICAgZW52ID0g
Y3B1X2Vudihjcyk7CisgICAgICAgIGdfYXNzZXJ0KGVudi0+dGhyZWFkSWQgPCBUSFJFQURTX01B
WCk7CisgICAgICAgIGlmICgobWFzayAmICgweDEgPDwgZW52LT50aHJlYWRJZCkpKSB7CisgICAg
ICAgICAgICBpZiAoZ2V0X2V4ZV9tb2RlKGVudikgPT0gSEVYX0VYRV9NT0RFX1dBSVQpIHsKKyAg
ICAgICAgICAgICAgICBoZXhhZ29uX3Jlc3VtZV90aHJlYWQoZW52KTsKKyAgICAgICAgICAgIH0K
KyAgICAgICAgfQorICAgIH0KK30KKwogdm9pZCBoZXhhZ29uX21vZGlmeV9zc3IoQ1BVSGV4YWdv
blN0YXRlICplbnYsIHVpbnQzMl90IG5ldywgdWludDMyX3Qgb2xkKQogewogICAgIGdfYXNzZXJ0
KGJxbF9sb2NrZWQoKSk7CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyBi
L3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCmluZGV4IGRmZjYwOTJkZDhhLi45MDkwYTVjMjBh
YiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hl
eGFnb24vb3BfaGVscGVyLmMKQEAgLTE1ODYsNyArMTU4Niw4IEBAIHZvaWQgSEVMUEVSKHdhaXQp
KENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBQQykKIAogdm9pZCBIRUxQRVIocmVzdW1l
KShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgbWFzaykKIHsKLSAgICBnX2Fzc2VydF9u
b3RfcmVhY2hlZCgpOworICAgIEJRTF9MT0NLX0dVQVJEKCk7CisgICAgaGV4YWdvbl9yZXN1bWVf
dGhyZWFkcyhlbnYsIG1hc2spOwogfQogCiB1aW50MzJfdCBIRUxQRVIoZ2V0aW1hc2spKENQVUhl
eGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCB0aWQpCi0tIAoyLjM0LjEKCg==

