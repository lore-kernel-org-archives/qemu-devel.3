Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E84FC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuB6z-0004h3-Ji; Wed, 12 Aug 2026 11:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wuB6Z-0004LU-4P
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:42:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wuB6W-0000Eo-1G
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:42:58 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CDbbuX3995467
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:42:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +u29WSyWl7DeLROVonyo7ApcUUoFSFPKVa/I0TtDg/s=; b=O4MboyYkgpZCdokp
 lwz7DPsqxXrM+DudbAWf5s9h108UkWZxdtvWNaEPalB9vZu7Mrc2um5osszxIeug
 nLpFvNKy2nA16PfnUcp6kYn64EZ3vP9RqWHmnSTGE6wum5Rllt3dyZ4xGXPACsYA
 fVehnYSrG5VQaJiqt+vXLGDaG0fO7rwUNk5Tx90am4SgbXe3kEGJblAyA/99l9Ih
 LBZ6YheB1VSH2TCzn4ATorn5x8/Zj3klwkiTSBDt6A+JRc5ogLg2p9ZrI5ppt8VM
 3nPop9O2kbMQD9NTtw+uHeqxd6PJPEnRdKgDJab8XaDMFHSbsWqSs1d6wsvE1h31
 FfhZ3Q==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0m6rj3ww-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:42:49 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-84c4cd31b51so28737b3a.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 08:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786549369; x=1787154169; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+u29WSyWl7DeLROVonyo7ApcUUoFSFPKVa/I0TtDg/s=;
 b=MQbXQPBpv3Xp9FOzIlhZQ1V/jgQdW9c8c8B3ZOrU5se981KdnWIgxYNuDNxcUZ7uB0
 qzyiEv+1nv9Jh5dsH8Nn7v2TGrFeLU/htTduB7EsKeUYl3Xone4WZ+Vx+CZ7od/3p8el
 DUCLVQhTUXJ+zZ4qOjoORXJUdwouv85T7EOpRxczpvsdcurfn8MXsI9yS2PQiZ+NIniB
 HrW3OommkOPrDbViLFW/bUgFh1YzkMAnzOV0s/QbB9OCvkrsltjHOaL9S4P+RILiVvlJ
 RNtLVVQoPRWqw5HqL4hG7UQhP38pBw7a8VLUiR808i7X/ZXkaEMidPGgx2ScbG4t5Ytv
 zCRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786549369; x=1787154169;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+u29WSyWl7DeLROVonyo7ApcUUoFSFPKVa/I0TtDg/s=;
 b=Hx9rSDZFn3YgBDtecDebHnpt8o5Tds1dAecHduDutWcrvlzeGz5y5ee5xJkeWMsl76
 kLWW3d5rVyzCo4WYBnw+m6zSEExXc6HGCl9PVMWVlONKJp4O9HQd0DmkQbxduEfbZfh/
 yqwBaL3g6sv+qGOwGQapMUa7mLQFBUdkNeLeiDZ+ASrRZInOp+MExusYJmvjMiZ4cWHg
 UiSeN6Pl7NVCWnHFx7/RLzh/bhUG8Tl6d17Jw47/VkLIOd5LCHzxivmtlENPzCo1pRdq
 evV/I+y1BJMkYEXZDoYISzDCUDPEZwkKK83X9LleZaSe8OkIjEwO9cDjZ5FYjF49S9o+
 4TLw==
X-Gm-Message-State: AOJu0YzOgwaNmPNddyvmPnw05MApgoIZ4Ct7wY3Txf/X7tXEiS1a1hvd
 oDPX0OWcWEiJqEp7zcHfpaSNTCQ/slBvI+9MonmW4HavvnuUbu4F5yd7qC5U3duG2vIpyb/8CeX
 6CtUHRPbv/xZDk3u/wsGN/PODoAaXYQtY0tr43DIrWFwO+hr03Sy3vaofKO8MeeaUQA==
X-Gm-Gg: AR+sD13taXYF5wZCpiKO9+I7q7wQQvazW8rfV5hR3UZQMkVwdNzDytWx4eySz131zqQ
 dwJpcyXIUxv2JCJCEG7qHZB4s2MC3WQ+OlB3ycs5BSXAXK1JpQWSgDZpp9jb5Cu+YdkrwYT6pcw
 RHDxLJpp/s0aAUPCDzH3hqzd31hcMcufDiVHHgBJTdwzHwF6zTDuEev4lsVN4CiyChDdo9gUaF8
 JghkzDsMJSYekRDRO3JgbHmnRYWkesVjD2kdgBqPZt9Kcpk2pCg3s8hXkPnvg++1+GdXoO5od4v
 smaELzcd3p8hfgw0F9WImMDeU9HpxhNn7WqU4tPrvTjdGPPfzloPUOQCUElQ2pXp8PqWGeNCwDF
 kC5GBvnZbg61iiHua4/1r0H+tHBt9myBiDEd2pqGI+7AieNIA
X-Received: by 2002:a05:6a20:939f:b0:3ba:d7b0:fcac with SMTP id
 adf61e73a8af0-3cc52fab6eamr145406637.5.1786549368671; 
 Wed, 12 Aug 2026 08:42:48 -0700 (PDT)
X-Received: by 2002:a05:6a20:939f:b0:3ba:d7b0:fcac with SMTP id
 adf61e73a8af0-3cc52fab6eamr145344637.5.1786549368115; 
 Wed, 12 Aug 2026 08:42:48 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31da7bf64b5sm8121190eec.10.2026.08.12.08.42.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 08:42:46 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 06/41] bitops.h: Add find_first_bit32()
Date: Wed, 12 Aug 2026 08:41:45 -0700
Message-Id: <20260812154220.1029828-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260812154220.1029828-1-brian.cain@oss.qualcomm.com>
References: <20260812154220.1029828-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyOCBTYWx0ZWRfX9fWeckKbHvd7
 63HG7xaf76N1pNvUOh10q8g03LyypBLUL/dkJJ6MoOpIFlPpkKHcW/l2r3f6TjU7BW11xnNOeqK
 2OqZ96oOMxxlrHN+01QScmOfek3vwPwhE5AP2rXG1Cx9s6BSIoMa9huLbkjYZv12EkAsIBGiWZk
 oDeoE5zDhopNNr0GpBM2H9ql6pDwFWdunapzHZbHllI9JM2XOLHDmyL7IN8Aa1Sh1n9Pia5iUdJ
 /LzM9DbJtNyL0ErYuwhyUvtfe52qG9vkSjekdIto5EULP7bvZkPj7WwKMKnqmw1jtK1q462ggRy
 ibX+3DEqvqpyHRpKGNPpD1OvpW+KHyJzzFEAQLjta4eg6dw21LPRDQc6XMOvYankO2HRt1PrQTz
 91hVj4xSnoyAFSZucCRoqHwsoPgbHj3ZkHjWUt0xk8rf37spCaKQsqiarlZ00W/CBPpkCU2rA2T
 zeFPqub/3yP2BJ4zvtg==
X-Authority-Analysis: v=2.4 cv=Wb08rUhX c=1 sm=1 tr=0 ts=6a7c9479 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=w2bVgGKsJa40EddZz84A:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: PFf9KYOtVU9nsK1BUxgocM5hgvYXiQsj
X-Proofpoint-ORIG-GUID: PFf9KYOtVU9nsK1BUxgocM5hgvYXiQsj
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyOCBTYWx0ZWRfX5VNxeLWBnamI
 CTmJquHl/Z0tNyfd0hjvJ4rSjgKD9RGj30plV7Os8u+EPEIBuowXgbVCONlzxJTRj/7BXvUJXbJ
 dH2F2kbRWXbT9l6n+MM3XM5Xjkaf5xU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120128
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

c2V0X2JpdDMyKCkvdGVzdF9iaXQzMigpL2V0YyBhbHJlYWR5IGxldCBkZXZpY2VzIG9wZXJhdGUg
b24KZ3Vlc3QtdmlzaWJsZSB1aW50MzJfdCByZWdpc3RlciBhcnJheXMgd2l0aG91dCBkZXBlbmRp
bmcgb24gdGhlIGhvc3QncwondW5zaWduZWQgbG9uZycgc2l6ZS4gIEFkZCBmaW5kX2ZpcnN0X2Jp
dDMyKCkgc28gY2FsbGVycyBuZWVkIG5vdCBjYXN0CmEgdWludDMyX3QgYXJyYXkgdG8gJ3Vuc2ln
bmVkIGxvbmcgKicuCgpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91
dmllckBvc3MucXVhbGNvbW0uY29tPgpMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11
LWRldmVsLzIwMjYwODA2MDQyNzIzLjM3ODUzNjktNy1icmlhbi5jYWluQG9zcy5xdWFsY29tbS5j
b20KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29t
PgotLS0KIGluY2x1ZGUvcWVtdS9iaXRvcHMuaCB8IDMwICsrKysrKysrKysrKysrKysrKysrKysr
KysrLS0tLQogMSBmaWxlIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9xZW11L2JpdG9wcy5oIGIvaW5jbHVkZS9xZW11L2JpdG9w
cy5oCmluZGV4IGM3YjgzOGE2MjgzLi5mNzM2M2E1NDc5ZiAxMDA2NDQKLS0tIGEvaW5jbHVkZS9x
ZW11L2JpdG9wcy5oCisrKyBiL2luY2x1ZGUvcWVtdS9iaXRvcHMuaApAQCAtNDMsMTAgKzQzLDkg
QEAKICAqIGJlIHNvbWUgZ3Vlc3QtdmlzaWJsZSByZWdpc3RlciB2aWV3IG9mIHRoZSBiaXQgYXJy
YXkuCiAgKgogICogV2UgZG8gbm90IGN1cnJlbnRseSBpbXBsZW1lbnQgdWludDMyX3QgdmVyc2lv
bnMgb2YgZmluZF9sYXN0X2JpdCgpLAotICogZmluZF9uZXh0X2JpdCgpLCBmaW5kX25leHRfemVy
b19iaXQoKSwgZmluZF9maXJzdF9iaXQoKSBvcgotICogZmluZF9maXJzdF96ZXJvX2JpdCgpLCBi
ZWNhdXNlIHdlIGhhdmVuJ3QgeWV0IG5lZWRlZCB0aGVtLiBJZiB5b3UKLSAqIG5lZWQgdGhlbSB5
b3Ugc2hvdWxkIGltcGxlbWVudCB0aGVtIHNpbWlsYXJseSB0byB0aGUgJ3Vuc2lnbmVkIGxvbmcn
Ci0gKiB2ZXJzaW9ucy4KKyAqIGZpbmRfbmV4dF9iaXQoKSwgZmluZF9uZXh0X3plcm9fYml0KCkg
b3IgZmluZF9maXJzdF96ZXJvX2JpdCgpLAorICogYmVjYXVzZSB3ZSBoYXZlbid0IHlldCBuZWVk
ZWQgdGhlbS4gSWYgeW91IG5lZWQgdGhlbSB5b3Ugc2hvdWxkCisgKiBpbXBsZW1lbnQgdGhlbSBz
aW1pbGFybHkgdG8gdGhlICd1bnNpZ25lZCBsb25nJyB2ZXJzaW9ucy4KICAqCiAgKiBZb3UgY2Fu
IGRlY2xhcmUgYSBiaXRtYXAgdG8gYmUgdXNlZCB3aXRoIHRoZXNlIGZ1bmN0aW9ucyB2aWEgdGhl
CiAgKiBERUNMQVJFX0JJVE1BUCBhbmQgREVDTEFSRV9CSVRNQVAzMiBtYWNyb3MgaW4gYml0bWFw
LmguCkBAIC0zODIsNiArMzgxLDI5IEBAIHN0YXRpYyBpbmxpbmUgaW50IHRlc3RfYml0MzIobG9u
ZyBuciwgY29uc3QgdWludDMyX3QgKmFkZHIpCiAgICAgcmV0dXJuIDFVICYgKGFkZHJbQklUMzJf
V09SRChucildID4+IChuciAmIDMxKSk7CiB9CiAKKy8qKgorICogZmluZF9maXJzdF9iaXQzMiAt
IGZpbmQgdGhlIGZpcnN0IHNldCBiaXQgaW4gYSBtZW1vcnkgcmVnaW9uCisgKiBAYWRkcjogVGhl
IGFkZHJlc3MgdG8gc3RhcnQgdGhlIHNlYXJjaCBhdAorICogQHNpemU6IFRoZSBtYXhpbXVtIHNp
emUgdG8gc2VhcmNoCisgKgorICogUmV0dXJucyB0aGUgYml0IG51bWJlciBvZiB0aGUgZmlyc3Qg
c2V0IGJpdCwKKyAqIG9yIEBzaXplIGlmIHRoZXJlIGlzIG5vIHNldCBiaXQgaW4gdGhlIGJpdG1h
cC4KKyAqLworc3RhdGljIGlubGluZSB1aW50MzJfdCBmaW5kX2ZpcnN0X2JpdDMyKGNvbnN0IHVp
bnQzMl90ICphZGRyLCB1aW50MzJfdCBzaXplKQoreworICAgIHVpbnQzMl90IHJlc3VsdDsKKwor
ICAgIGZvciAocmVzdWx0ID0gMDsgcmVzdWx0IDwgc2l6ZTsgcmVzdWx0ICs9IDMyKSB7CisgICAg
ICAgIHVpbnQzMl90IHRtcCA9ICphZGRyKys7CisgICAgICAgIGlmICh0bXApIHsKKyAgICAgICAg
ICAgIHJlc3VsdCArPSBjdHozMih0bXApOworICAgICAgICAgICAgcmV0dXJuIHJlc3VsdCA8IHNp
emUgPyByZXN1bHQgOiBzaXplOworICAgICAgICB9CisgICAgfQorICAgIC8qIE5vdCBmb3VuZCAq
LworICAgIHJldHVybiBzaXplOworfQorCiAvKioKICAqIERPQzogTWlzY2VsbGFuZW91cyBiaXQg
b3BlcmF0aW9ucyBvbiBzaW5nbGUgdmFsdWVzCiAgKgotLSAKMi4zNC4xCgo=

