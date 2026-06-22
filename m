Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 158C3CDB476
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 22:34:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbn8t-0003JC-2T; Mon, 22 Jun 2026 18:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbn8q-0003I6-SE
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:29:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbn8m-0006Bt-NW
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:29:19 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJarVw2177096
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 22:29:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=2bTqkaayXHvx1tK63Al2vAr6LUw4GX3XcKczCBU7MVM=; b=M3
 kz+tLacTzp695Pf8lHwQ5my2Y/12Z3MIaJvAplLiao95C/sizBoM/PgMhcaAPimV
 3UGCvsPKyGSIlRQU3+g13VM50aK3IbhueuSGeRAqyrm4hS06+0INhMjUBQaNypH9
 pMJBGcoCcD9D9yGNWA2Z9OOuAO0TylyAWTUPruCg1U74zG9gh1TRaaCQxII3t9wo
 sSNbU8vitT6g6/x2iQMJzyMQfPt8pcGm3gcPkZ+L5znaLuZ0G1uM+6z6YVTpK0xT
 VbiUxGuMUAGGEHu8iz2a3deBl7rDcaabnlMR6nkyzXpl7vS6yGaec7L9H6WUyahc
 /rf+IW66+Im8WRMQ9KlA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey37hahbf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 22:29:13 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c1f6c5559so5826620eec.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 15:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782167353; x=1782772153; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2bTqkaayXHvx1tK63Al2vAr6LUw4GX3XcKczCBU7MVM=;
 b=HYMwhxGrwx4ugU+am8eplrK5ddOLEZjUr0SekpFZDcRgAjSx04wzMNJ6UjTDBzbZzQ
 Vam6wuPtDDn+RIQ9pIpJl0rLIYeZOLFtZ0MOyk5Rwt6827qpEqu+ZZVNi3bd1EggEtYO
 a/bDqPbIKlKOKGuxAlFA90T+7FWsMg2cs7X8+c6VTrcHDAoOcVVsR1m8PvQQ6YIAsjbl
 me0xx4y7ZPWcu9F18JvHzXiXzRwGh83X2WWAOuXKVA1oGydxyqESFmx3K0IFT2bQSta5
 Bt1A+P0+eP2waraEsifrWJzhOb3GFCI/g7mAPFwyMAdLgxqxmY6lXMQtIJF8UWFsUMa6
 XVCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782167353; x=1782772153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2bTqkaayXHvx1tK63Al2vAr6LUw4GX3XcKczCBU7MVM=;
 b=QbWkOMPlNWxqsWRl+KIKoziMX+nkkhTt9BT2Ff0ACQJFOVUFeRlI/e3OfK7x7YW97s
 Fh9oLI8imMbuBdzDsMbSIppUMii1KPLbQcJ6avpGq03ZYeclV/BKFOgsPkAar/TJJLv+
 mg4ypECLKA1qrJcmrND17Ag1gW7PJLw/M2OOWDP3NNb54SRiVh+7TC3a0Yz1HOnd0MYD
 ys9JGjA92p8IheljDUJ+E0qEEc5gEznEIK8VO1abV4SZ1LflxaIYbht+X90XqSYLM/VX
 PDdNYFWRLakUabM6sA15IqoZr6ST4OtF3/zbtlJKWAr5nIoUus5Lp1qKFB2xuZ9RQ81C
 GQYw==
X-Gm-Message-State: AOJu0YytdUP+eex0qBXBlVPzlHaTQOL1hragn0O/dXj/SBcbOsTsM0Lg
 2Ug1IWAwey1k9KATxT4qqLlBvjzGwP3cjZr+SGLqCG2yHwVZvT21Gz6Kk7zhPKs79r/49caX9PU
 3fRmYqL8PpCnMVJ/w2ql0P1q7fq3BC7bhU/q47OdDV7z6ac6PKjj5UZT34oCbc7nH+Q==
X-Gm-Gg: AfdE7cm+9kJyFXpAxKYE6/n2NyZGXgY+jDkE1j1xwt7me+/cZ5IgkDY5yQrDlCMCsPx
 wc4RZt3nAOHW3F0twZyH9QF2P+NERq0bcqOTtuo4sbUvuH7S0wZ/TO88OpuPC+HZgMfDs4cS7gY
 QQmcdM1bdPT9j3zXMgiaH4Afww1CL0ijNuVBOsKRvTXm3tALv7sUCRWA5hJ9hmf6n1UanJo6+wS
 w0e3k8Lh2VnK4KBAwnXBnBA0NMHGAR3sogaQ196aSx8SeZyVwSInhjcaYlqxFLIZsw8KzbMtW3P
 keFqMTjzYbTzTiW0jyG8fyqRYfAsVC9/kPdGmrng2+iVGjknEjU58oUVWFlxHKZK2I0zsJnAf86
 cAh7QWQU6T2xexc2EjPzyXoCPyt5fa/mabuVWvQ+WiUn1Ta5xhrigLcq+/mM=
X-Received: by 2002:a05:7301:4083:b0:2cb:4b8f:b2bd with SMTP id
 5a478bee46e88-30c06ffd51cmr10492707eec.6.1782167352836; 
 Mon, 22 Jun 2026 15:29:12 -0700 (PDT)
X-Received: by 2002:a05:7301:4083:b0:2cb:4b8f:b2bd with SMTP id
 5a478bee46e88-30c06ffd51cmr10492689eec.6.1782167352362; 
 Mon, 22 Jun 2026 15:29:12 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d78esm10945995eec.18.2026.06.22.15.29.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 15:29:11 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 01/75] target/hexagon: use cmd_array() instead of get_id()
Date: Mon, 22 Jun 2026 15:27:50 -0700
Message-Id: <20260622222904.607771-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
References: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: zm0lhLQuC6FBqwRzKkdWIgTifU3k_2s3
X-Authority-Analysis: v=2.4 cv=ecANubEH c=1 sm=1 tr=0 ts=6a39b739 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8
 a=SrZkeIdwbWuKvdoqoQQA:9 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIxNiBTYWx0ZWRfX9E1v4WW7G8l7
 opGNkKUi84QPNNI3KQW+c2Qt6WNlOCEtJRsD+Jd8YaxxkGR+RnJM3fB25B/EYypdcn3Z6QlJA9k
 mKEDSSwx1Vh7oLxpfZY/7qYgM+F4G/s=
X-Proofpoint-GUID: zm0lhLQuC6FBqwRzKkdWIgTifU3k_2s3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIxNiBTYWx0ZWRfX1EunEwVfxy/T
 3Kck1/WPxx0m11Zsr96y2cS/czpK8++JWojcimBQlKYlqCjU4hFmd1kHzxfHBaudMMA5FmFa46V
 C8g/OFF/yzks86WDJqZACMD+RybECeZCldcHDCsiUZqqwen8rXaIYSTxVsBBPyLXXDPG0UfHnZB
 XPnG5I5lv4MhGYuonErOI/muzhMX2XbuqIi3bqaNevxWAJVRgxOSvRebXitGawJCUA7eRPR9zqX
 /9PIW6PoYj9tnjD0TycSXwX0Dof9VC8RcfVyZp1Cb0UrY9EW5wyJXEAd+JKh7HF8RINLF8NW6m0
 Zs4j9naiHEfeJ3UtibL+aYEhdh794mbuNHqimN1+ZNyCj1f3UZTr+/IjtcE0QkScfKVg8tKUNIx
 W1m9EYimbysfxvOmoiWFc3MkAKNZGHSzpxBLDNRhSaabjYdLZ7VpT7Q9vUL89FIfQI+8Z7k34ze
 YVCpiH9a7F+jjS7Cddw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220216
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Z2V0X2lkKCkgcmV0dXJucyB0aGUgY29tcGlsZXIncyBzaG9ydCBuYW1lIG5vdCBhIHByb2dyYW0u
ClBhc3NpbmcgaXQgZGlyZWN0bHkgYXMgdGhlIGNvbW1hbmQgZm9yIHRoZSBpZGVmLXBhcnNlciBw
cmVwcm9jZXNzaW5nCmN1c3RvbV90YXJnZXQgaGFwcGVuZWQgdG8gd29yayBmb3IgbmF0aXZlIGdj
Yy9jbGFuZyBidWlsZHMgYnV0CmJyZWFrcyB1bmRlciBjcm9zcyBjb21waWxlcnMgc3VjaCBhcyBl
bWNjIG9yIGFueSBjY2FjaGUtd3JhcHBlZCBjb21waWxlci4KCkxpbms6IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL3FlbXUtZGV2ZWwvQ0FKU1AwUVd6UUVnb1lNQ2daWCs5akN2clY2TzNScW5BK2Rm
MURwVDJSNk1adlZYaU5nQG1haWwuZ21haWwuY29tLwpSZXZpZXdlZC1ieTogU3RlZmFuIEhham5v
Y3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgpSZXZpZXdlZC1ieTogUGhpbGlwcGUgTWF0aGlldS1E
YXVkw6kgPHBoaWxtZEBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWlu
IDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vbWVzb24u
YnVpbGQgfCA0ICsrLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vbWVzb24uYnVpbGQgYi90YXJnZXQv
aGV4YWdvbi9tZXNvbi5idWlsZAppbmRleCBkMTY5Y2Y3MWIyZi4uZmYyMmI0ZTQ3MDYgMTAwNjQ0
Ci0tLSBhL3RhcmdldC9oZXhhZ29uL21lc29uLmJ1aWxkCisrKyBiL3RhcmdldC9oZXhhZ29uL21l
c29uLmJ1aWxkCkBAIC0yNzAsMTMgKzI3MCwxMyBAQCBpZiBpZGVmX3BhcnNlcl9lbmFibGVkIGFu
ZCAnaGV4YWdvbi1saW51eC11c2VyJyBpbiB0YXJnZXRfZGlycwogICAgICAgICBjb21tYW5kOiBb
cHl0aG9uLCBmaWxlcygnZ2VuX2lkZWZfcGFyc2VyX2Z1bmNzLnB5JyksIHNlbWFudGljc19nZW5l
cmF0ZWQsICdAT1VUUFVUQCddLAogICAgICkKIAotICAgIGNvbXBpbGVyID0gbWVzb24uZ2V0X2Nv
bXBpbGVyKCdjJykuZ2V0X2lkKCkKKyAgICBjb21waWxlciA9IG1lc29uLmdldF9jb21waWxlcign
YycpLmNtZF9hcnJheSgpCiAgICAgcHJlcHJvY2Vzc2VkX2lkZWZfcGFyc2VyX2lucHV0X2dlbmVy
YXRlZCA9IGN1c3RvbV90YXJnZXQoCiAgICAgICAgICdpZGVmX3BhcnNlcl9pbnB1dC5wcmVwcm9j
ZXNzZWQuaC5pbmMnLAogICAgICAgICBvdXRwdXQ6ICdpZGVmX3BhcnNlcl9pbnB1dC5wcmVwcm9j
ZXNzZWQuaC5pbmMnLAogICAgICAgICBpbnB1dDogaWRlZl9wYXJzZXJfaW5wdXRfZ2VuZXJhdGVk
LAogICAgICAgICBkZXBlbmRfZmlsZXM6IFtpZGVmX3BhcnNlcl9kaXIgLyAnbWFjcm9zLmguaW5j
J10sCi0gICAgICAgIGNvbW1hbmQ6IFtjb21waWxlciwgJy14JywgJ2MnLCAnLUUnLCAnLUknLCBp
ZGVmX3BhcnNlcl9kaXIsICctbycsICdAT1VUUFVUQCcsICdASU5QVVRAJ10sCisgICAgICAgIGNv
bW1hbmQ6IGNvbXBpbGVyICsgWycteCcsICdjJywgJy1FJywgJy1JJywgaWRlZl9wYXJzZXJfZGly
LCAnLW8nLCAnQE9VVFBVVEAnLCAnQElOUFVUQCddLAogICAgICkKIAogICAgIGZsZXggPSBnZW5l
cmF0b3IoCi0tIAoyLjM0LjEKCg==

